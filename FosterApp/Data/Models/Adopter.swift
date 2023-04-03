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
    
    init?(from coreDataObject: DB_Adopter?) {
        guard let adopter = coreDataObject else { return nil }
        self.firstName = adopter.a_firstName
        self.lastName = adopter.a_lastName
        self.adress = adopter.a_adress
        self.numberPhone = adopter.a_numberPhone
        self.comment = adopter.a_comment
        self.kittens = (adopter.r_kitten?.allObjects as? [DB_Kitten])?.compactMap { kitten in
            Kitten(from: kitten)
        }
    }
}
