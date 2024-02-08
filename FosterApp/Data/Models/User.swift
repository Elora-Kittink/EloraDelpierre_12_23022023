//
//  User.swift
//  FosterApp
//
//  Created by Elora on 13/04/2023.
//

import Foundation
import FirebaseAuth

/// Model structure for a user.
struct User: Equatable {
    
    var mail: String
    var name: String
    var id: String
    
//	/// Initializes a new `User` instance from a CoreData `DB_User` object.
//	/// - Parameter coreDataObject: The `DB_User` instance to convert.
//    init?(from coreDataObject: DB_User) {
//        guard let id = coreDataObject.a_id,
//              let name = coreDataObject.a_name,
//              let mail = coreDataObject.a_mail else {
//            return nil
//        }
//        self.id = id
//        self.name = name
//        self.mail = mail
//    }
	
	/// Initializes a new `User` instance from form data.
	/// - Parameters:
	///   - mail: Email address of the user.
	///   - id: Unique identifier for the user.
	///   - name: Name of the user.
    init(mail: String,
         id: String,
         name: String) {
        self.name = name
        self.id = id
        self.mail = mail
    }
	
	/// Initializes a new `User` instance from Firebase authentication response.
	/// - Parameter response: The Firebase authentication user response.
	init(from response: FirebaseAuth.User) {
		self.name = response.displayName ?? ""
		self.id = response.uid
		self.mail = response.email ?? ""
	}
}
