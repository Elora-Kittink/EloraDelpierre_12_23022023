//
//  Kitten.swift
//  FosterApp
//
//  Created by Elora on 24/02/2023.
//

import Foundation

struct Kitten: Equatable {
    static func == (lhs: Kitten, rhs: Kitten) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String?
//    var litter: Litter
    var litterId: String
    var firstName: String?
    var secondName: String?
    var birthdate: Date?
    var sex: String?
    var color: String?
//   TODO: n'est pas à choisir puisqu'elle corresponds à la date de sauvetage de la portée?
//    -> si parce qu'on peut créer une portée avec des chatons de differentes provenance? 
    var rescueDate: Date?
    //    var siblings: [Kitten]?
    var comment: String?
    var isAdopted: Bool
    var microship: Int?
    var vaccines: [Vaccine]?
    var adopters: Adopter?
    var weightHistory: [Weight]?
    var isAlive: Bool
    
    init?(from coreDataObject: DB_Kitten) {
        guard let id = coreDataObject.a_id,
              let dblitter = coreDataObject.r_litter,
              let litterId = coreDataObject.r_litter?.a_id
        else { return nil }
        
        self.id = id
        self.litterId = litterId
        self.firstName = coreDataObject.a_firstName ?? "A compléter !"
        self.secondName = coreDataObject.a_secondName
        self.birthdate = coreDataObject.a_birthdate
        self.sex = coreDataObject.a_sex
        self.color = coreDataObject.a_color
        self.rescueDate = coreDataObject.a_rescueDate ?? Date()
        //        self.siblings =  self.litter?.kittens?.filter {
        //            $0.id != self.id
        //        }
        self.comment = coreDataObject.a_comment
        self.isAdopted = coreDataObject.a_isAdopted
        self.microship = Int(coreDataObject.a_microship)
        self.vaccines = (coreDataObject.r_vaccine?.allObjects as? [DB_Vaccine])?.compactMap { vaccine in
             Vaccine(from: vaccine)
        }
        self.weightHistory = (coreDataObject.r_weight?.allObjects as? [DB_Weight])?.compactMap { weight in
            Weight(from: weight)
        }
        self.adopters = Adopter(from: coreDataObject.r_adopter)
        self.isAlive = coreDataObject.a_isAlive
    }
    
    init(from id: String?,
         litter: Litter,
         firstName: String?,
         secondName: String?,
         birthdate: Date?,
         sex: String?,
         color: String?,
         rescueDate: Date?,
         siblings: [Kitten]?,
         comment: String?,
         isAdopted: Bool,
         microship: Int?,
         vaccines: [Vaccine]?,
         adopters: Adopter?,
         weightHistory: [Weight]?,
         isAlive: Bool) {
        self.id = id
//        self.litter = litter
        self.litterId = litter.id ?? ""
        self.firstName = firstName
        self.secondName = secondName
        self.birthdate = birthdate
        self.sex = sex
        self.color = color
        self.rescueDate = rescueDate
        //        self.siblings =  siblings
        self.comment = comment
        self.isAdopted = isAdopted
        self.microship = microship
        self.vaccines = vaccines
        self.weightHistory = weightHistory
        self.adopters = adopters
        self.isAlive = isAlive
    }
}
