//
//  DB_Litter.swift
//  FosterApp
//
//  Created by Elora on 28/02/2023.
//

import Foundation
import CoreDataUtilsKit

/// Extension to `DB_Litter` to conform to `CoreDataModel` protocol.
extension DB_Litter: CoreDataModel {
	public static var primaryKey: String { "a_id" }
	public static var entityName: String { "DB_Litter" }
}

/// Extension to add additional methods to the `DB_Litter` model.
extension DB_Litter {
	/// Creates a new `DB_Litter` instance in the database from a `Litter` model.
	/// - Parameters:
	///   - rescueDate: The date of the litter's rescue.
	///   - user: The `User` associated with the litter.
	/// - Returns: An optional `DB_Litter` instance if creation is successful.
	static func create(rescueDate: Date) -> DB_Litter? {
		let litter = DB_Litter.findOrCreate(with: UUID().uuidString)
		litter?.a_rescueDate = rescueDate
		litter?.a_isOngoing = true
		litter?.a_isFavorite = false
		
		return litter
	}
	/// Sets the ongoing status of the litter to false, marking it as archived.
	func archiveLitter() {
		self.a_isOngoing = false
	}
	
	/// Switches the favorite status between litters.
	/// - Parameters:
	///   - oldFavorite: Array of `DB_Litter` instances previously marked as favorite.
	///   - newFavorite: The `DB_Litter` instance to be marked as the new favorite.
	func makeFavorite(oldFavorite: [DB_Litter], newFavorite: DB_Litter) {
		oldFavorite.map { litter in
			litter.a_isFavorite = false
		}
		newFavorite.a_isFavorite = true
	}
}
