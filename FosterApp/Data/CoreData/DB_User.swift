//
//  DB_User.swift
//  FosterApp
//
//  Created by Elora on 13/04/2023.
//

import Foundation
import CoreDataUtilsKit

// TODO: continuer la création de User et la connecter avec l'authentification Firebase

extension DB_User: CoreDataModel {
    public static var primaryKey: String { "a_id" }
    public static var entityName: String { "DB_User" }
}

extension DB_User {
    
    static func create(user: User) -> DB_User {
        
    }
}
