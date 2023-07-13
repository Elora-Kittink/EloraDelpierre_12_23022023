//
//  Weight.swift
//  FosterApp
//
//  Created by Elora on 28/02/2023.
//

import Foundation

struct Weighing: Equatable {
    
    var date: Date?
    var kittenWeight: Float?
	var mealWeight: Float?
	var id: String?
	
    init(from coreDataObject: DB_Weighing) {
        self.date = coreDataObject.a_date
        self.kittenWeight = coreDataObject.a_kittenWeight
		self.mealWeight = coreDataObject.a_mealWeight	
    }
	
	init(date: Date, kittenWeight: Float, mealWeight: Float) {
		self.date = date
		self.kittenWeight = kittenWeight
		self.mealWeight = mealWeight
	}
}
