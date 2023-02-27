//
//  DataListenerDelegate.swift
//  Hager Data Kit
//
//  Created by RGMC on 22/01/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation
import CoreData
import UIKit

/**
 Protocol that provide listener methods called on core data CRUD operations
 The core data model needs to be listened with `listen` method first
 */
public protocol DataListenerDelegate: AnyObject {
    
    func didChange(object: Any)
    func didInsert(object: Any, at indexPath: IndexPath)
    func didDelete(object: Any, at indexPath: IndexPath)
    func didUpdate(object: Any, at indexPath: IndexPath)
    func didMove(object: Any, from indexPath: IndexPath, to newIndexPath: IndexPath)
    
    func didChange(inserted: [NSManagedObject], updated: [NSManagedObject], deleted: [NSManagedObject])
    func didInsert(objects: [NSManagedObject])
    func didUpdate(objects: [NSManagedObject])
    func didDelete(objects: [NSManagedObject])
    
    func contextDidSave()
}

extension DataListenerDelegate {
    
    /**
     Tell the delegate that a specific object has been change
     */
    public func didChange(object: Any) {}
    
    /**
     Tell the delegate that a specific object has been inserted at indexPath
     */
    public func didInsert(object: Any, at indexPath: IndexPath) {}
    
    /**
        Tell the delegate that a specific object has been deleted from indexPath
    */
    public func didDelete(object: Any, at indexPath: IndexPath) {}
    
    /**
        Tell the delegate that a specific object has been updated at indexPath
    */
    public func didUpdate(object: Any, at indexPath: IndexPath) {}
    
    /**
        Tell the delegate that a specific object has been moved from indexPath to newIndexPath
    */
    public func didMove(object: Any, from indexPath: IndexPath, to newIndexPath: IndexPath) {}
    
    /**
        Tell the delegate that all objects who has been inserted, updated or deleted
    */
    public func didChange(inserted: [NSManagedObject], updated: [NSManagedObject], deleted: [NSManagedObject]) {}
    
    /**
     Tell the delegate all objects who changed
     */
    public func didInsert(objects: [NSManagedObject]) {}
    
    /**
     Tell the delegate all objects who updated
     */
    public func didUpdate(objects: [NSManagedObject]) {}
    
    /**
     Tell the delegate all objects who deleted
     */
    public func didDelete(objects: [NSManagedObject]) {}
    
    /**
     Tell the delegate than context did save
     */
    public func contextDidSave() {}
}

extension DataListenerDelegate {
    
    /**
     Imitating the original delegate method from `NSFetchedResultsControllerDelegate` to catch and propagate CRUD operations
     The `NSFetchedResultsControllerDelegate` delegate is implemented by default on NSObject, further implementation is not needed
     */
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                           didChange anObject: Any,
                           at indexPath: IndexPath?,
                           for type: NSFetchedResultsChangeType,
                           newIndexPath: IndexPath?) {
        didChange(object: anObject)
        switch type {
        case .insert:
            if let indexPath: IndexPath = newIndexPath {
                didInsert(object: anObject, at: indexPath)
            }
            
        case .delete:
            if let indexPath: IndexPath = indexPath {
                didDelete(object: anObject, at: indexPath)
            }
            
        case .update:
            if let indexPath: IndexPath = indexPath {
                didUpdate(object: anObject, at: indexPath)
            }
            
        case .move:
            if let indexPath: IndexPath = indexPath, let newIndexPath: IndexPath = newIndexPath {
                didMove(object: anObject, from: indexPath, to: newIndexPath)
            }
        @unknown default: break
        }
    }
}

extension DataListenerDelegate {
    
    /**
     Provide a `NSFetchedResultsController` for a core data entity implementing `CoreDataModel` protocol
     This model will be automatically listened and CRUD operations will be propagated through this protocol methods
     */
    public func listen<T: CoreDataModel>(on delegate: NSFetchedResultsControllerDelegate,
                                         context: NSManagedObjectContext? = nil,
                                         predicate: NSPredicate? = nil,
                                         sortDescriptors: [NSSortDescriptor] = [],
                                         sectionNameKeyPath: String? = nil,
                                         cacheName: String? = nil) throws -> NSFetchedResultsController<T> {
        
        let fetchRequest: NSFetchRequest<T> = T.fetchRequest()
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = predicate
        
        let currentContext: NSManagedObjectContext
        if let context: NSManagedObjectContext = context {
            currentContext = context
        } else {
            currentContext = try CoreDataManager.default.getContext()
        }
        
        let fetchedResultController = NSFetchedResultsController<T>(fetchRequest: fetchRequest,
                                                                    managedObjectContext: currentContext,
                                                                    sectionNameKeyPath: sectionNameKeyPath,
                                                                    cacheName: cacheName)
        fetchedResultController.delegate = delegate
        
        try fetchedResultController.performFetch()
        
        if let delegate: (NSObject & NSFetchedResultsControllerDelegate) = delegate as? NSObject & NSFetchedResultsControllerDelegate {
            NotificationCenter.default.addObserver(delegate,
                                                   selector: #selector(delegate.contextObjectDidChange),
                                                   name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                                   object: context)
        }
        
        return fetchedResultController
    }
}


extension NSObject: NSFetchedResultsControllerDelegate {
    
    @objc fileprivate func contextObjectDidChange(notification: Notification) {
        if let delegate = self as? DataListenerDelegate {
            guard let userInfo = notification.userInfo else { return }
            
            var allInserted: [NSManagedObject] = []
            var allDeleted: [NSManagedObject] = []
            var allUpdated: [NSManagedObject] = []
            
            if let inserts: Set<NSManagedObject> = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject>, !inserts.isEmpty {
                delegate.didInsert(objects: Array(inserts))
                allInserted.append(contentsOf: Array(inserts))
            }
            
            if let updates: Set<NSManagedObject> = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject>, !updates.isEmpty {
                delegate.didUpdate(objects: Array(updates))
                allUpdated.append(contentsOf: Array(updates))
            }
            
            if let updates: Set<NSManagedObject> = userInfo[NSRefreshedObjectsKey] as? Set<NSManagedObject>, !updates.isEmpty {
                delegate.didUpdate(objects: Array(updates))
                allUpdated.append(contentsOf: Array(updates))
            }
            
            if let deletes: Set<NSManagedObject> = userInfo[NSDeletedObjectsKey] as? Set<NSManagedObject>, !deletes.isEmpty {
                delegate.didDelete(objects: Array(deletes))
                allDeleted.append(contentsOf: Array(deletes))
            }
            
            let allChangedObjects: [NSManagedObject] = allDeleted + allUpdated + allInserted
            if !allChangedObjects.isEmpty {
                delegate.didChange(inserted: allInserted, updated: allUpdated, deleted: allDeleted)
            }
        }
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                           didChange anObject: Any,
                           at indexPath: IndexPath?,
                           for type: NSFetchedResultsChangeType,
                           newIndexPath: IndexPath?) {
        if let delegate = self as? DataListenerDelegate {
            delegate.controller(controller, didChange: anObject, at: indexPath, for: type, newIndexPath: newIndexPath)
        }
    }
}
