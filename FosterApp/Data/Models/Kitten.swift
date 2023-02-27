//
//  Kitten.swift
//  FosterApp
//
//  Created by Elora on 24/02/2023.
//

import Foundation


struct Kitten {
    var firstName: String
    var secondName: String?
    var birthdate: Date
    var sex: String
    var color: String
    var rescueDate: Date
    var siblings: [Kitten]
    var comment: String?
    var isAdopted: Bool
    var microship: Int?
    var isTestsDone: Bool
    var vaccines: [Date : String]?
    var adopters: Adopter?
    var weightHistory: [Date : Float]?
}
