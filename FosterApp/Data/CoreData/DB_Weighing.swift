//
//  DB_Weight.swift
//  FosterApp
//
//  Created by Elora on 28/02/2023.
//

import Foundation
import CoreDataUtilsKit

/// Extension to `DB_Weighing` to conform to `CoreDataModel` protocol.
extension DB_Weighing: CoreDataModel {
    public static var primaryKey: String { "a_id" }
    public static var entityName: String { "DB_Weighing" }
}

/// Extension to add additional methods to the `DB_Weighing` model.
extension DB_Weighing {
    
	/// Creates a new `DB_Weighing` instance in the database from a `Weighing` model.
	/// - Parameters:
	///   - weighing: The `Weighing` model to be converted.
	///   - kitten: The `Kitten` associated with the weighing.
	/// - Returns: An optional `DB_Weighing` instance if creation is successful.
	static func create(weighing: Weighing, kitten: Kitten) -> DB_Weighing? {
		guard let DBKitten = DB_Kitten.get(with: kitten.id) else {return nil}
		
		let DBWeighing = DB_Weighing.findOrCreate(with: weighing.id)
		// Mapping properties from `Weighing` to `DB_Weighing`
		DBWeighing?.a_date = weighing.date
		DBWeighing?.a_kittenWeight = weighing.kittenWeight ?? ""
		DBWeighing?.a_mealWeight = weighing.mealWeight ?? ""
		DBWeighing?.r_kitten = DBKitten
		
		return DBWeighing
	}
	
	/// Updates an existing `DB_Weighing` instance in the database with new information from a `Weighing` model.
	/// - Parameter weighing: The `Weighing` model containing updated information.
    func update(weighing: Weighing) {
        self.a_date = weighing.date
        self.a_kittenWeight = weighing.kittenWeight ?? ""
		self.a_mealWeight = weighing.mealWeight ?? ""
    }
}
