//
//  DB_Litter.swift
//  FosterApp
//
//  Created by Elora on 28/02/2023.
//

import Foundation
import CoreDataUtilsKit

extension DB_Litter: CoreDataModel {
    public static var primaryKey: String { "a_id" }
    public static var entityName: String { "DB_Litter" }
}

extension DB_Litter {
    
    func update(litter: Litter) {
        
        self.a_rescueDate = litter.rescueDate
        self.a_isOngoing = litter.isOngoing
    }
    
    func create(litter: Litter) {
        self.a_id = UUID().uuidString
        self.a_rescueDate = litter.rescueDate
        self.a_isOngoing = true
    }
    
    func addKitten(kitten: Kitten) {
//        kitten.litter = self
    }
    
    func archiveLitter() {
        self.a_isOngoing = false
    }
}
