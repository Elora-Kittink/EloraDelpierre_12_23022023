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
    
    static func create(rescueDate: String) -> DB_Litter? {
        let litter = DB_Litter.findOrCreate(with: UUID().uuidString)
        litter?.a_rescueDate = rescueDate
        litter?.a_isOngoing = true
        litter?.a_isFavorite = false
        return litter
    }
    
    func addKitten(kitten: Kitten) {
//        kitten.litter = self
    }
    
    func archiveLitter() {
        self.a_isOngoing = false
    }
    
    func makeFavorite(oldFavorite: [DB_Litter], newFavorite: DB_Litter) {
        oldFavorite.map { litter in
            litter.a_isFavorite = false
        }
        newFavorite.a_isFavorite = true
    }
}
