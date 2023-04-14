//
//  DB_User.swift
//  FosterApp
//
//  Created by Elora on 13/04/2023.
//

import Foundation
import CoreDataUtilsKit

extension DB_User: CoreDataModel {
    public static var primaryKey: String { "a_id" }
    public static var entityName: String { "DB_User" }
}

extension DB_User {
    
    static func create(user: User) -> DB_User? {
        let DBuser = DB_User.findOrCreate(with: user.id)
        DBuser?.a_id = user.id
        DBuser?.a_mail = user.mail
        DBuser?.a_name = user.name
        
        return DBuser
    }
    
     func update(user: User) {
        self.a_mail = user.name
        self.a_name = user.name
    }
}
