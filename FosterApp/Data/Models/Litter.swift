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
    
    init(from coreDataObject: DB_Litter){
//        self.kittens = (coreDataObject.r_kitten?.allObjects as? [DB_Kitten])?.compactMap { kitten in
//            return Kitten(from: kitten)
//        }
        self.isOngoing = coreDataObject.a_isOngoing
        self.rescueDate = coreDataObject.a_rescueDate
        self.id = coreDataObject.a_id
    }
//    faire un init from les données entrées dans le forulaire?

    init(id: String? = nil,
         kittens: [Kitten]? = nil,
         isOngoing: Bool,
         rescueDate: Date? = nil) {
        self.id = id
        self.kittens = kittens
        self.isOngoing = isOngoing
        self.rescueDate = rescueDate
    }
}
