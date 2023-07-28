//
//  DB_Weight.swift
//  FosterApp
//
//  Created by Elora on 28/02/2023.
//

import Foundation
import CoreDataUtilsKit

extension DB_Weighing: CoreDataModel {
    public static var primaryKey: String { "a_id" }
    public static var entityName: String { "DB_Weighing" }
}

extension DB_Weighing {
    
	static func create(weighing: Weighing, kitten: Kitten) -> DB_Weighing? {
		guard let DBKitten = DB_Kitten.get(with: kitten.id) else {return nil}
		
		let DBWeighing = DB_Weighing.findOrCreate(with: weighing.id)
		DBWeighing?.a_date = weighing.date
		DBWeighing?.a_kittenWeight = weighing.kittenWeight ?? ""
		DBWeighing?.a_mealWeight = weighing.mealWeight ?? ""
		DBWeighing?.r_kitten = DBKitten
		
		return DBWeighing
	}
	
    func update(weighing: Weighing) {
        self.a_date = weighing.date
        self.a_kittenWeight = weighing.kittenWeight ?? ""
		self.a_mealWeight = weighing.mealWeight ?? ""
    }
}
