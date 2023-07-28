//
//  Weight.swift
//  FosterApp
//
//  Created by Elora on 28/02/2023.
//

import Foundation

struct Weighing: Equatable {
    
    var date: Date?
    var kittenWeight: Double?
	var mealWeight: Double?
	var id: String?
	
    init(from coreDataObject: DB_Weighing) {
        self.date = coreDataObject.a_date
        self.kittenWeight = coreDataObject.a_kittenWeight
		self.mealWeight = coreDataObject.a_mealWeight
		self.id = coreDataObject.a_id
    }
	
	init(id: String?, date: Date, kittenWeight: Double, mealWeight: Double) {
		self.date = date
		self.kittenWeight = kittenWeight
		self.mealWeight = mealWeight
		self.id = id
	}
}
