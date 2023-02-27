//
//  CoreDataManager.swift
//  Hager Data Kit
//
//  Created by RGMC on 12/01/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//
import Foundation
import CoreData
import UIKit
import UtilsKit

/**
 Wrapper class to easily manage core data and entities with `CoreDataModel` protocol
 The context is managed by this class:
 - On the main thread, the main context is used
 - On background thread, a background context is used; created if it doesn't exist and persistent until it is purged with `save` method
 As long as the background context is not purged, it will remain the only one on the thread
 */
public final class CoreDataManager {
    
    /**
     Shared instance
     */
    public static var `default`: CoreDataManager = CoreDataManager()
    
    // MARK: - Core Data stack
    private var persistentContainer: NSPersistentContainer?
    
    // MARK: - Background Contexts
    private let backgroundGroup = DispatchGroup()
    private let backgroundContextsAccessQueue = DispatchQueue(label: "backgroundContextsAccessQueue")
    private var _backgroundContexts: [String: NSManagedObjectContext] = [:]
    private var backgroundContexts: [String: NSManagedObjectContext] {
        set {
            backgroundContextsAccessQueue.sync { [weak self] in
                self?._backgroundContexts = newValue
            }
        }
        get {
            backgroundContextsAccessQueue.sync {
                _backgroundContexts
            }
        }
    }
    
    // MARK: - Setup
    /**
     Set the core data stack
     - parameter model : Name of the `xcdatamodel`
     */
    public func setCoreDataStack(_ name: String, bundleId: String? = nil) throws {
        if
            let bundleId: String = bundleId,
            let bundle = Bundle(identifier: bundleId),
            let modelURL: URL = bundle.url(forResource: name, withExtension: "momd"),
            let model = NSManagedObjectModel(contentsOf: modelURL) {
            self.persistentContainer = NSPersistentContainer(name: name, managedObjectModel: model)
        } else {
            self.persistentContainer = NSPersistentContainer(name: name)
        }
        
        guard let persistentContainer = self.persistentContainer else { throw CoreDataError.unknownPersistentContainer(name: name, bundle: bundleId) }
        
        persistentContainer.loadPersistentStores { [weak self] _, error in
            if let error: NSError = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            self?.persistentContainer?.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            self?.persistentContainer?.viewContext.automaticallyMergesChangesFromParent = true
        }
    }
}

// MARK: - Core Data contexts management
extension CoreDataManager {
    
    /**
     - returns: If the current thread is the main thread, return the main context, otherwise return the background context corresponding to the thread
     */
    public func getContext() throws -> NSManagedObjectContext {
        guard let persistentContainer = self.persistentContainer else {
            log(.coredata, "Getting context", error: CoreDataError.noPersistentContainer)
            throw CoreDataError.noPersistentContainer
        }
        
        defer {
            self.backgroundGroup.leave()
        }
        self.backgroundGroup.wait()
        self.backgroundGroup.enter()
        
        if Thread.current.isMainThread { return persistentContainer.viewContext }
        
        if let backgroundContext = self.self.backgroundContexts[Thread.current.id] {
            return backgroundContext
        } else {
            return try self.createNewBackgroundContext()
        }
    }
    
    /**
     Create a context in a background thread and it in background contexts stack
     Attach an id to the context to allow only one context per thread
     */
    private func createNewBackgroundContext() throws -> NSManagedObjectContext {
        guard let persistentContainer = self.persistentContainer else { throw CoreDataError.noPersistentContainer }
        
        let newContext: NSManagedObjectContext = persistentContainer.newBackgroundContext()
        let token: String = Thread.current.id
        
        newContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        self.backgroundContexts[token] = newContext
        
        return newContext
    }
    
    /**
     Save the current context
     - parameter purge : wether the context needs to be purge or not. Works only for background context
     */
    public func save(purge: Bool = true) throws {
        guard let persistentContainer = self.persistentContainer else { throw CoreDataError.noPersistentContainer }
        
        var mainError: Error?
        let isMainContext: Bool = persistentContainer.viewContext == (try self.getContext())
        
        if try self.getContext().hasChanges {
            try self.performAndWait { [weak self] in
                do {
                    try self?.getContext().save()
                } catch {
                    mainError = error
                    log(.coredata, "\(isMainContext ? "Main" : "Background") context saved", error: error)
                }
            }
            
            if let mainError: Error = mainError { throw mainError }
            
            // Purge background context if needed
            if purge { self.backgroundContexts.removeValue(forKey: Thread.current.id) }
        }
        
        log(.coredata, "\(isMainContext ? "Main" : "Background") context saved")
    }
    
    /**
     Save the current context and log error if exist
     - parameter purge : wether the context needs to be purge or not. Works only for background context
     */
    public func save(purge: Bool = true, errorCompletion: ((Error) -> Void)?) {
        do {
            try save(purge: purge)
        } catch {
            errorCompletion?(error)
        }
    }
}

// MARK: - Core Data FETCH requests
extension CoreDataManager {
    
    // Fetch with predicate
    internal func fetch<T: NSManagedObject>(entity: String,
                                            with predicate: NSPredicate? = nil,
                                            sortedKey: String? = nil,
                                            ascending: Bool? = true) -> [T] {
        var objects: [T]?
        
        try? self.performAndWait { [weak self] in
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
            fetchRequest.predicate = predicate
            if let sortedKey: String = sortedKey, let ascending: Bool = ascending {
                let sortDescriptor = NSSortDescriptor(key: sortedKey, ascending: ascending)
                fetchRequest.sortDescriptors = [sortDescriptor]
            }
            objects = (try? self?.getContext().fetch(fetchRequest)) as? [T]
        }
        
        return objects ?? []
    }
    
    internal func fetch<T: CoreDataModel>(predicate: NSPredicate? = nil,
                                          sortedKey: String? = nil,
                                          ascending: Bool? = true) -> [T] {
        self.fetch(entity: T.entityName, with: predicate, sortedKey: sortedKey, ascending: ascending)
    }
    
    // Fetch with primary key
    internal func fetch<T: CoreDataModel>(with primaryKey: PrimaryKey) -> [T] {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: T.entityName)
        fetchRequest.predicate = T.predicate(with: primaryKey)
        return (try? self.getContext().fetch(fetchRequest)) as? [T] ?? []
    }
    
    // Fetch first with predicate
    internal func fetchFirst<T: NSManagedObject>(entity: String, with predicate: NSPredicate? = nil) -> T? {
        self.fetch(entity: entity, with: predicate).first
    }
    
    internal func fetchFirst<T: CoreDataModel>(predicate: NSPredicate? = nil) -> T? {
        self.fetchFirst(entity: T.entityName, with: predicate)
    }
    
    // Fetch first with primary key
    internal func fetchFirst<T: CoreDataModel>(with primaryKey: PrimaryKey) -> T? {
        self.fetch(with: primaryKey).first
    }
    
    // Create
    internal func create<T: CoreDataModel>() -> T? {
        var object: T?
        
        try? self.performAndWait { [weak self] in
            guard let self = self, let context: NSManagedObjectContext = try? self.getContext() else { return }
            object = NSEntityDescription.insertNewObject(forEntityName: T.entityName, into: context) as? T
        }
        
        return object
    }
    
    internal func fetchOrCreate<T: CoreDataModel>(with primaryKey: PrimaryKey) -> T? {
        if let object: T = self.fetch(with: primaryKey).first {
            return object
        }
        
        var object: T?
        
        try? self.performAndWait { [weak self] in
            guard let self = self, let context: NSManagedObjectContext = try? self.getContext() else { return }
            object = NSEntityDescription.insertNewObject(forEntityName: T.entityName, into: context) as? T
            // Input must Be INT or STRING, we don't managed other format
            let entityDescription: NSEntityDescription? = object?.entity
            let primaryKeyAttribute: NSAttributeDescription? = entityDescription?.attributesByName[T.primaryKey]
            if primaryKeyAttribute?.attributeType == .stringAttributeType {
                object?.setValue(primaryKey.stringValue, forKey: T.primaryKey)
            } else {
                object?.setValue(primaryKey.intValue, forKey: T.primaryKey)
            }
        }
        
        return object
    }
}

// MARK: - Core Data DELETE requests
extension CoreDataManager {
    
    internal func performAndWait(_ block: () -> Void) throws {
        let context: NSManagedObjectContext = try self.getContext()
        let masterThreadId: String = Thread.current.id
        
        try self.getContext().performAndWait { [weak self] in
            self?.backgroundContexts[Thread.current.id] = context
            block()
            if masterThreadId != Thread.current.id {
                self?.backgroundContexts.removeValue(forKey: Thread.current.id)
            }
        }
    }
    
    // Delete one object
    internal func delete<T: NSManagedObject>(object: T) throws {
        try self.performAndWait { [weak self] in
            try? self?.getContext().delete(object)
        }
    }
    
    internal func delete<T: CoreDataModel>(with primaryKey: PrimaryKey) -> [T] {
        if let object: T = fetchOrCreate(with: primaryKey) {
            do {
                try delete(object: object)
            } catch {
                return []
            }
        }
        return fetch()
    }
    
    // Delete with predicate
    internal func delete<T: NSManagedObject>(entity: String, with predicate: NSPredicate? = nil) -> [T] {
        let objects: [T] = fetch(entity: entity, with: predicate)
        
        objects.forEach { [weak self] in try? self?.getContext().delete($0) }
        
        return fetch(entity: entity)
    }
    
    internal func delete<T: CoreDataModel>(predicate: NSPredicate? = nil) -> [T] {
        self.delete(entity: T.entityName, with: predicate)
    }
    
    /**
     Drop the entire database
     */
    public func dropDatabase() throws {
        guard let persistentContainer = self.persistentContainer else { throw CoreDataError.noPersistentContainer }
        
        persistentContainer.managedObjectModel.entities.forEach { [weak self] entity in
            guard let entityName: String = entity.name else { return }
            
            _ = self?.delete(entity: entityName)
            do {
                try self?.persistentContainer?.viewContext.save()
                log(.coredata, "Database droped")
            } catch {
                log(.coredata, "Drop Database", error: error)
            }
        }
    }
} 
extension NSManagedObject {
    
    /**
     Get all entities compliant with the given predicate using `CoreDataManager` class
     - parameter entity: the name of the core data model
     - parameter predicate: a predicate or nil
     - returns: all found entities
     */
    public static func getAll<T: NSManagedObject>(entity: String, with predicate: NSPredicate? = nil) -> [T] {
        CoreDataManager.default.fetch(entity: entity, with: predicate)
    }
    
    /**
     Delete the entity corresponding to the given predicate using `CoreDataManager` class
     - parameter predicate: the predicate of the entities to delete
     - parameter entity: the name of the core data model
     - returns: all deleted entities
     */
    public static func deleteAll(entity: String, with predicate: NSPredicate? = nil) -> [NSManagedObject] {
        CoreDataManager.default.delete(entity: entity, with: predicate)
    }
    
    /**
     Delete the entity using `CoreDataManager` class
     */
    public func delete() throws {
        try CoreDataManager.default.delete(object: self)
    }
}
