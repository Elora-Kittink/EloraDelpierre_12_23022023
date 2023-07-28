//
//  Weight.swift
//  FosterApp
//
//  Created by Elora on 28/02/2023.
//

import Foundation

struct Weighing: Equatable {
    
    var date: Date?
    var kittenWeight: String?
	var mealWeight: String?
	var id: String?
	
    init(from coreDataObject: DB_Weighing) {
        self.date = coreDataObject.a_date
        self.kittenWeight = coreDataObject.a_kittenWeight
		self.mealWeight = coreDataObject.a_mealWeight
		self.id = coreDataObject.a_id
    }
	
	init(id: String?, date: Date, kittenWeight: String, mealWeight: String) {
		self.date = date
		self.kittenWeight = kittenWeight
		self.mealWeight = mealWeight
		self.id = id
	}
}
//TODO: faire une custom cell avec trois cases : date, pesée chaton, pesée lait

class WeighingCell: BaseCell<Weighing> {
	
//	override var item: Weighing? {
//		didSet {
//			textLabel?.text = item?.kittens?.compactMap { kitten in
//				kitten.firstName
//			}
//			.joined(separator: ", ") ?? "Pas encore de chaton"
//		}
//	}
}
