//
//  DB_Kitten.swift
//  FosterApp
//
//  Created by Elora on 28/02/2023.
//

import Foundation
import CoreDataUtilsKit

extension DB_Kitten: CoreDataModel {
    public static var primaryKey: String { "a_id" }
    public static var entityName: String { "DB_Kitten" }
}

extension DB_Kitten {
    
    func Update(kitten: Kitten) {
        guard let birthdateString = kitten.birthdate?.toString(format: "ddMMyyyy"),
              let firstname = kitten.firstName
        else { return }
        
        self.a_isAlive = true
        self.a_id = "\(firstname)\(birthdateString)"
        self.a_firstName = kitten.firstName
        self.a_sex = kitten.sex
        self.a_secondName = kitten.secondName
        self.a_color = kitten.color
        self.a_birthdate = kitten.birthdate
        self.a_microship = Int64(kitten.microship ?? 0)
        self.a_isAdopted = kitten.isAdopted
        self.a_rescueDate = kitten.rescueDate
        self.a_comment = kitten.comment
//        self.r_weight = NSSet(array: DB_Weight)
//        self.r_litter = kitten.litter
    }
}
