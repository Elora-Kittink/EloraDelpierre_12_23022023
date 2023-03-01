//
//  Vaccine.swift
//  FosterApp
//
//  Created by Elora on 28/02/2023.
//

import Foundation

struct Vaccine {
    
    var date: Date?
    var vaccine: String?
    
    init?(from coreDataObject: DB_Vaccine){
        self.date = coreDataObject.a_date
        self.vaccine = coreDataObject.a_vaccine
    }
}
