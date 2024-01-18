//
//  Kitten.swift
//  FosterApp
//
//  Created by Elora on 24/02/2023.
//

import Foundation

/// A UITableViewCell subclass representing a kitten.
class KittenCell: BaseCell<Kitten> {
	
	/// Updates the cell when a new `Kitten` item is set.
	override var item: Kitten? {
		didSet {
			textLabel?.text = item?.firstName
		}
	}
}

/// Model structure for a kitten.
struct Kitten: Equatable {
	// Equatable conformance to compare `Kitten` instances.
	static func == (lhs: Kitten, rhs: Kitten) -> Bool {
		lhs.id == rhs.id
	}
	
	// Properties defining a kitten
	var id: String?
	var litterId: String
	var firstName: String?
	var secondName: String?
	var birthdate: Date?
	var sex: String?
	var color: String?
	var rescueDate: Date?
	var comment: String?
	var isAdopted: Bool
	var microship: Int?
	var tattoo: String?
	var vaccines: [Vaccine]?
	var adopters: Adopter?
	var weighingHistory: [Weighing]?
	var isAlive: Bool
	
	/// Initializes a new `Kitten` instance from a CoreData `DB_Kitten` object.
	/// - Parameter coreDataObject: The `DB_Kitten` instance to convert.
	init?(from coreDataObject: DB_Kitten) {
		guard let id = coreDataObject.a_id,
			  let _ = coreDataObject.r_litter,
			  let litterId = coreDataObject.r_litter?.a_id
		else { return nil }
		
		self.id = id
		self.litterId = litterId
		self.firstName = coreDataObject.a_firstName ?? "A compléter !"
		self.secondName = coreDataObject.a_secondName
		self.birthdate = coreDataObject.a_birthdate
		self.sex = coreDataObject.a_sex
		self.color = coreDataObject.a_color
		self.rescueDate = coreDataObject.a_rescueDate ?? Date()
		self.comment = coreDataObject.a_comment
		self.isAdopted = coreDataObject.a_isAdopted
		self.microship = Int(coreDataObject.a_microship)
		self.tattoo = coreDataObject.a_tattoo
		self.vaccines = (coreDataObject.r_vaccine?.allObjects as? [DB_Vaccine])?.compactMap { vaccine in
			Vaccine(from: vaccine)
		}
		self.weighingHistory = (coreDataObject.r_weighing?.allObjects as? [DB_Weighing])?.compactMap { weighing in
			Weighing(from: weighing)
		}
		self.adopters = Adopter(from: coreDataObject.r_adopter)
		self.isAlive = coreDataObject.a_isAlive
	}
	
	/// Initializes a new `Kitten` instance from form data.
	/// - Parameters:
	///   - id: Unique identifier for the kitten.
	///   - litter: The `Litter` associated with the kitten.
	///   - firstName: The first name of the kitten.
	///   - secondName: The second name of the kitten.
	///   - birthdate: The birth date of the kitten.
	///   - sex: The sex of the kitten.
	///   - color: The color of the kitten.
	///   - rescueDate: The date when the kitten was rescued.
	///   - siblings: An array of `Kitten` instances representing the siblings.
	///   - comment: Additional comments about the kitten.
	///   - isAdopted: Indicates if the kitten has been adopted.
	///   - microship: The microchip number of the kitten, if available.
	///   - tattoo: The tattoo identifier of the kitten, if available.
	///   - vaccines: An array of `Vaccine` instances representing the vaccines the kitten has received.
	///   - adopters: The `Adopter` associated with the kitten, if the kitten has been adopted.
	///   - weighingHistory: An array of `Weighing` instances representing the weight history of the kitten.
	///   - isAlive: Indicates if the kitten is alive.
	init(id: String?,
		 litter: Litter,
		 firstName: String?,
		 secondName: String?,
		 birthdate: Date?,
		 sex: String?,
		 color: String?,
		 rescueDate: Date?,
		 siblings: [Kitten]?,
		 comment: String?,
		 isAdopted: Bool,
		 microship: Int?,
		 tattoo: String?,
		 vaccines: [Vaccine]?,
		 adopters: Adopter?,
		 weighingHistory: [Weighing]?,
		 isAlive: Bool) {
		self.id = id
		self.litterId = litter.id ?? ""
		self.firstName = firstName
		self.secondName = secondName
		self.birthdate = birthdate
		self.sex = sex
		self.color = color
		self.rescueDate = rescueDate
		self.comment = comment
		self.isAdopted = isAdopted
		self.microship = microship
		self.tattoo = tattoo
		self.vaccines = vaccines
		self.weighingHistory = weighingHistory
		self.adopters = adopters
		self.isAlive = isAlive
	}
}
