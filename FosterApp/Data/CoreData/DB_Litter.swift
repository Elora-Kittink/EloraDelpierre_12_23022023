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
    
    static func create(rescueDate: String) -> DB_Litter? {
        let litter = DB_Litter.findOrCreate(with: UUID().uuidString)
        litter?.a_rescueDate = rescueDate
        litter?.a_isOngoing = true
        return litter
    }
    
    func addKitten(kitten: Kitten) {
//        kitten.litter = self
    }
    
    func archiveLitter() {
        self.a_isOngoing = false
    }
}
