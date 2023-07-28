//
//  Litter.swift
//  FosterApp
//
//  Created by Elora on 27/02/2023.
//

import Foundation

struct Litter: Equatable {
	var id: String?
	var kittens: [Kitten]?
	var isOngoing: Bool
	var rescueDate: String?
	var isFavorite: Bool
	
	init(from coreDataObject: DB_Litter) {
		self.kittens = (coreDataObject.r_kittens?.allObjects as? [DB_Kitten])?.compactMap { kitten in
			Kitten(from: kitten)
		}
		self.isOngoing = coreDataObject.a_isOngoing
		self.rescueDate = coreDataObject.a_rescueDate?.toString(format: "dd/MM/yyyy")
		self.id = coreDataObject.a_id
		self.isFavorite = coreDataObject.a_isFavorite
	}
	
	init(id: String? = nil,
		 kittens: [Kitten]? = nil,
		 isOngoing: Bool,
		 rescueDate: String?, isFavorite: Bool = false) {
		
		self.id = id
		self.kittens = kittens
		self.isOngoing = isOngoing
		self.rescueDate = rescueDate
		self.isFavorite = isFavorite
	}
}

class LitterCell: BaseCell<Litter> {
	
	override var item: Litter? {
		didSet {
			textLabel?.text = item?.kittens?.compactMap { kitten in
				kitten.firstName
			}
			.joined(separator: ", ") ?? "Pas encore de chaton"
		}
	}
}
