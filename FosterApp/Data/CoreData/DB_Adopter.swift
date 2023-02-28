//
//  DB_Adopter.swift
//  FosterApp
//
//  Created by Elora on 28/02/2023.
//

import Foundation
import CoreDataUtilsKit

extension DB_Adopter: CoreDataModel {
    public static var primaryKey: String { "a_id" }
    public static var entityName: String { "DB_Adopter" }
}

extension DB_Adopter {
    
    func updateAdopter(adopter: Adopter) {
        self.a_firstName = adopter.firstName
        self.a_lastName = adopter.lastName
        self.a_adress = adopter.adress
        self.a_numberPhone = adopter.numberPhone
        self.a_comment = adopter.comment
    }
}
