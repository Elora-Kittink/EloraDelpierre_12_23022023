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
    
    static func create(rescueDate: Date, user: User) -> DB_Litter? {
        guard let user = DB_User.get(with: user.id) else {
            print("👹 DB fail to get user for this litter")
            return nil
        }
        print("🙋🏼‍♀️ user for this litter is \(user.a_id)")
        let litter = DB_Litter.findOrCreate(with: UUID().uuidString)
        litter?.a_rescueDate = rescueDate
        litter?.a_isOngoing = true
        litter?.a_isFavorite = false
        litter?.r_user = user
        
                return litter
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
