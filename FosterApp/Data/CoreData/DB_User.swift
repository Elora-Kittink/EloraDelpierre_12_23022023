//
//  DB_User.swift
//  FosterApp
//
//  Created by Elora on 13/04/2023.
//

import Foundation
import CoreDataUtilsKit

/// Extension to `DB_User` to conform to `CoreDataModel` protocol.
/// This allows for easier interaction with CoreData functionalities.
extension DB_User: CoreDataModel {
    public static var primaryKey: String { "a_id" }
    public static var entityName: String { "DB_User" }
}

/// Extension to add additional methods to the `DB_User` model.
extension DB_User {


	/// Creates a new `DB_User` instance in the database from a `User` model.
	/// - Parameter user: The `User` model to be converted.
	/// - Returns: An optional `DB_User` instance if creation is successful.
    static func create(user: User) -> DB_User? {
        let DBuser = DB_User.findOrCreate(with: user.id)
		// Mapping properties from `User` to `DB_User`
        DBuser?.a_id = user.id
        DBuser?.a_mail = user.mail
        DBuser?.a_name = user.name
        
        return DBuser
    }
    
	/// Updates an existing `DB_User` instance in the database with new information from a `User` model.
	/// - Parameter user: The `User` model containing updated information.
     func update(user: User) {
        self.a_mail = user.mail
        self.a_name = user.name
    }
}
