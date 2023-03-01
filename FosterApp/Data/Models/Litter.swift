//
//  Litter.swift
//  FosterApp
//
//  Created by Elora on 27/02/2023.
//

import Foundation

struct Litter {
    var id: String?
    var kittens: [Kitten]?
    var isOngoing: Bool
    var rescueDate:  Date?
    
    init?(from coreDataObject: DB_Litter){
        self.kittens = (coreDataObject.r_kitten?.allObjects as? [DB_Kitten])?.compactMap { kitten in
            return Kitten(from: kitten)
        }
        self.isOngoing = coreDataObject.a_isOngoing
        self.rescueDate = coreDataObject.a_rescueDate
        self.id = coreDataObject.a_id
    }
}
