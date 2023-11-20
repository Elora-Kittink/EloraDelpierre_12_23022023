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
    
    static func create(kitten: Kitten, litter: Litter) -> DB_Kitten? {
        guard let dbLitter = DB_Litter.get(with: litter.id)
        else { return nil}
        
        let DBkitten = DB_Kitten.findOrCreate(with: kitten.id)
        DBkitten?.a_sex = kitten.sex
        DBkitten?.a_rescueDate = kitten.rescueDate
        DBkitten?.a_birthdate = kitten.birthdate
        DBkitten?.a_color = kitten.color
        DBkitten?.a_firstName = kitten.firstName
        DBkitten?.a_secondName = kitten.secondName
        DBkitten?.a_comment = kitten.comment
        DBkitten?.a_microship = Int64(kitten.microship ?? 0)
		DBkitten?.a_tattoo = kitten.tattoo
        DBkitten?.a_isAlive = true
        DBkitten?.a_isAdopted = false
        DBkitten?.r_litter = dbLitter
        
		print("🐹 id created = \(DBkitten?.a_id)")
        return DBkitten
    }
    
    func update(kitten: Kitten, litterId: String) {
        
        guard let dbLitter = DB_Litter.get(with: litterId)
        else { return }
        guard let birthdateString = kitten.birthdate?.toString(format: "ddMMyyyy") else { return }
        self.a_isAlive = kitten.isAlive
        self.a_firstName = kitten.firstName
        self.a_sex = kitten.sex
        self.a_secondName = kitten.secondName
        self.a_color = kitten.color
        self.a_birthdate = kitten.birthdate
        self.a_microship = Int64(kitten.microship ?? 0)
		self.a_tattoo = kitten.tattoo
        self.a_isAdopted = kitten.isAdopted
        self.a_rescueDate = kitten.rescueDate
        self.a_comment = kitten.comment
        self.r_litter = dbLitter
    }
}
