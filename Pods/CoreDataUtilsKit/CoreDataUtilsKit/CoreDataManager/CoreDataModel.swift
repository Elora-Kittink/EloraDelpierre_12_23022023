//
//  CoreDataModel.swift
//  Hager Data Kit
//
//  Created by RGMC on 17/01/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation
import CoreData

/**
 Protocol to facilitate the use of core data with `CoreDataManager` class
 Gives methods to manage the corresponding entity
 */
public protocol CoreDataModel: NSManagedObject {
    /**
     The name of the core data entity
     */
    static var entityName: String { get }
    /**
     The attribute name of the primary key of the entity; basically an id used on CRUD operations
     */
    static var primaryKey: String { get }
}

extension CoreDataModel {
    
    /**
     Get Value of current entity  primary key
     */
    internal  var primaryKey: PrimaryKey? {
        var output: PrimaryKey?
        if let value: String = value(forKey: Self.primaryKey) as? String { output = value }
        if let value: Int = value(forKey: Self.primaryKey) as? Int { output = value }
        assert(output != nil, "your primary Key must be eather an INT or a STRING")
        return output
    }
}

// MARK: - Core Data Model extension
extension CoreDataModel {
    
    /**
     Create a basic fetch request
     - returns: a fetch request based on the entity's name
     */
    public static func fetchRequest() -> NSFetchRequest<Self> {
        NSFetchRequest<Self>(entityName: self.entityName)
    }
    
    /**
     Create a basic predicate
     - parameter primaryKey: primary key of the entity
     - returns: a predicate based on the given primary key
     */
    internal static func predicate(with primaryKey: PrimaryKey) -> NSPredicate {
        NSPredicate(format: "\(Self.primaryKey) = %@", primaryKey.stringValue ?? "")
    }
    
    // MARK: Core Data Model GET
    
    /**
     Create an entity
     - returns: the instance of the created entity or nil
     */
    public static func create() -> Self? {
        CoreDataManager.default.create()
    }
    
    /**
     Find an entity based on the given primary key if it exists, otherwise create it
     - parameter primaryKey: primary key of the entity to find
     - returns: the instance of the found or created entity
     */
    public static func findOrCreate(with primaryKey: PrimaryKey?) -> Self? {
        guard let typedKey = primaryKey else { return nil }
        return CoreDataManager.default.fetchOrCreate(with: typedKey)
    }
    
    /**
     Get all entities compliant with the given predicate
     - parameter predicate: a predicate or nil
     - returns: all found entities
     */
    public static func getAll(predicate: NSPredicate? = nil,
                              sortBy: String? = nil,
                              ascending: Bool? = true) -> [Self] {
        CoreDataManager.default.fetch(predicate: predicate, sortedKey: sortBy, ascending: ascending)
    }
    
    /**
     Get the entity corresponding to the given primary key
     - parameter primaryKey: primary key of the entity to find
     - returns: the instance of the found entity or nil if not found
     */
    public static func get(with primaryKey: PrimaryKey?) -> Self? {
        guard let typedKey = primaryKey else { return nil }
        return CoreDataManager.default.fetch(with: typedKey).first
    }

    /**
     Get the entities corresponding to the given primary keys
     - parameter primaryKeys: primary keys of the entities to find
     - returns: all found entities
     */
    public static func getAll(with primaryKeys: [PrimaryKey]) -> [Self] {
        self.getAll(predicate: NSPredicate(format: "\(Self.primaryKey) IN %@", primaryKeys))
    }
    
    /**
     Delete the entity corresponding to the given primary key
     - parameter primaryKey: primary key of the entity to delete
     - returns: the remaining entities
     */
    @discardableResult public static func delete(with primaryKey: PrimaryKey) -> [Self] {
        CoreDataManager.default.delete(with: primaryKey)
    }
    
    /**
     Delete the entity corresponding to the given predicate
     - parameter predicate: the predicate of the entities to delete
     - returns: all remaining entities
     */
    @discardableResult public static func deleteAll(predicate: NSPredicate? = nil) -> [Self] {
        CoreDataManager.default.delete(predicate: predicate)
    }
    
    /**
     Delete all entities except given primary keys
     - parameter except: primary keys of the entities to keep
     - returns: all remaining entities
     */
    @discardableResult public static func deleteAll(except primaryKeys: [PrimaryKey]) -> [Self] {
        self.deleteAll(predicate: NSPredicate(format: "NOT \(Self.primaryKey) IN %@", primaryKeys))
    }
}
