//
//  Adopters.swift
//  FosterApp
//
//  Created by Elora on 27/02/2023.
//

import Foundation
import UIKit

struct Adopter {
    var firstName: String?
    var lastName: String?
    var adress: String?
    var numberPhone: String?
    var comment: String?
    var kittens: [Kitten]?
    
    init?(from coreDataObject: DB_Adopter){
        self.firstName = coreDataObject.a_firstName
        self.lastName = coreDataObject.a_lastName
        self.adress = coreDataObject.a_adress
        self.numberPhone = coreDataObject.a_numberPhone
        self.comment = coreDataObject.a_comment
        self.kittens = (coreDataObject.r_kitten?.allObjects as? [DB_Kitten])?.compactMap { kitten in
            return Kitten(from: kitten)
        }
    }
}
