//
//  Kitten.swift
//  FosterApp
//
//  Created by Elora on 24/02/2023.
//

import Foundation


struct Kitten2 {
    var id: String
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

struct Kitten {
    var id: String?
    var litter: Litter?
    var firstName: String?
    var secondName: String?
    var birthdate: Date?
    var sex: String?
    var color: String?
    var rescueDate: Date?
    var siblings: [Kitten]?
    var comment: String?
    var isAdopted: Bool
    var microship: Int?
    var isTestsDone: Bool
    var vaccines: [Vaccine]?
    var adopters: Adopter?
    var weightHistory: [Weight]?
    var isAlive: Bool
    
    init?(from coreDataObject: DB_Kitten){
        
        self.id = coreDataObject.a_id
        self.litter = Litter(from: coreDataObject.r_litter)
        self.firstName = coreDataObject.a_firstName
        self.secondName = coreDataObject.a_secondName
        self.birthdate = coreDataObject.a_birthdate
        self.sex = coreDataObject.a_sex
        self.color = coreDataObject.a_color
        self.rescueDate = coreDataObject.a_rescueDate
        self.siblings =  self.litter?.kittens?.filter {
            $0.id != self.id
        }
        self.comment = coreDataObject.a_comment
        self.isAdopted = coreDataObject.a_isAdopted
        self.microship = Int(coreDataObject.a_microship)
        self.isTestsDone = coreDataObject.a_isTestsDone
        self.vaccines = (coreDataObject.r_vaccine?.allObjects as? [DB_Vaccine])?.compactMap { vaccine in
            return Vaccine(from: vaccine)
        }
        self.weightHistory = (coreDataObject.r_weight?.allObjects as? [DB_Weight])?.compactMap { weight in
            return Weight(from: weight)
        }
        self.adopters = Adopter(from: coreDataObject.r_adopter)
        self.isAlive = coreDataObject.a_isAlive
    }
}
