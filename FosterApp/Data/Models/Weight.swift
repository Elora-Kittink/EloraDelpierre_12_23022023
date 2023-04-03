//
//  Weight.swift
//  FosterApp
//
//  Created by Elora on 28/02/2023.
//

import Foundation

struct Weight {
    
    var date: Date?
    var weight: Float?
    
    init?(from coreDataObject: DB_Weight) { 
        self.date = coreDataObject.a_date
        self.weight = coreDataObject.a_weight
    }
}
