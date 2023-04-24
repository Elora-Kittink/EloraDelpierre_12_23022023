//
//  User.swift
//  FosterApp
//
//  Created by Elora on 13/04/2023.
//

import Foundation

struct User {
    
    var mail: String
    var name: String
    var id: String
    
    init?(from coreDataObject: DB_User) {
        guard let id = coreDataObject.a_id,
              let name = coreDataObject.a_name,
              let mail = coreDataObject.a_mail else {
            return nil
        }
        self.id = id
        self.name = name
        self.mail = mail
    }
    
    init(mail: String,
         id: String,
         name: String) {
        self.name = name
        self.id = id
        self.mail = mail
    }
}
