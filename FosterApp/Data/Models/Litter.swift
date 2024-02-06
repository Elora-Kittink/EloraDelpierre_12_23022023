//
//  Litter.swift
//  FosterApp
//
//  Created by Elora on 27/02/2023.
//

import Foundation

/// A UITableViewCell subclass representing a litter.
class LitterCell: BaseCell<Litter> {
	
	/// Updates the cell when a new `Litter` item is set.
	/// Displays a list of kitten names or a placeholder if no kittens are present.

	override var item: Litter? {
		didSet {
			let kittenList = item?.kittens?.compactMap { kitten in
				kitten.firstName
			}
			.joined(separator: ", ")
			textLabel?.text = kittenList?.isEmpty ?? true ? "Portée sans chaton créé" : kittenList
			textLabel?.accessibilityLabel = "chatons: \(kittenList ?? "aucun chatons dans cette portée pour l'instant")"
		}
	}
}

// Model structure for a litter.
struct Litter: Equatable {
	var id: String?
	var kittens: [Kitten]?
	var isOngoing: Bool
	var rescueDate: String?
	var isFavorite: Bool
	
	/// Initializes a new `Litter` instance from a CoreData `DB_Litter` object.
	/// - Parameter coreDataObject: The `DB_Litter` instance to convert.
	init(from coreDataObject: DB_Litter) {
		self.kittens = (coreDataObject.r_kittens?.allObjects as? [DB_Kitten])?.compactMap { kitten in
			Kitten(from: kitten)
		}
		self.isOngoing = coreDataObject.a_isOngoing
		self.rescueDate = coreDataObject.a_rescueDate?.toString(format: "dd/MM/yyyy")
		self.id = coreDataObject.a_id
		self.isFavorite = coreDataObject.a_isFavorite
	}
	
	/// Initializes a new `Litter` instance from form data.
	/// - Parameters:
	///   - id: Unique identifier for the litter.
	///   - kittens: Array of `Kitten` instances in the litter.
	///   - isOngoing: Indicates if the litter is ongoing.
	///   - rescueDate: Date of the litter's rescue.
	///   - isFavorite: Indicates if the litter is marked as favorite.
	init(isOngoing: Bool,
		 rescueDate: String?, 
		 isFavorite: Bool = false, 
		 id: String? = nil,
		 kittens: [Kitten]? = nil) {
		
		self.id = id
		self.kittens = kittens
		self.isOngoing = isOngoing
		self.rescueDate = rescueDate
		self.isFavorite = isFavorite
	}
}
