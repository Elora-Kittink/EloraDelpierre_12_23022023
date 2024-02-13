//  KittenCardModalInteractor.swift
//
//  Created by Elora on 03/04/2023.
//

import Foundation

/// `KittenCardModalInteractor` handles the business logic for the `KittenCardModalViewController`.
class KittenCardModalInteractor: Interactor
<
	KittenCardModalViewModel,
	KittenCardModalPresenter
> {
	
	let worker = DBWorker()
	
	/// Refreshes the view with the current state of kitten editing or creation.
	/// - Parameters:
	///   - isEdititngMode: A Boolean value indicating if the view is in editing mode.
	///   - isCreatingMode: A Boolean value indicating if the view is in creating mode.
	///   - kitten: The `Kitten` object being edited or created.
	func refresh(isEdititngMode: Bool, isCreatingMode: Bool, kitten: Kitten?) {
		
		if isEdititngMode {
			self.presenter.display(kitten: kitten)
		}
		if isCreatingMode {
			self.presenter.display(kitten: nil)
		}
		self.presenter.display(loader: false)
	}
	
	/// Composes a `Kitten` object from the provided details.
	/// - Parameters:
	///   - litter: The `Litter` object associated with the kitten.
	///   - firstName: The first name of the kitten.
	///   - secondName: The second name of the kitten.
	///   - birthdate: The birthdate of the kitten.
	///   - sex: The sex of the kitten.
	///   - color: The color of the kitten.
	///   - rescueDate: The rescue date of the kitten.
	///   - comment: Additional comments about the kitten.
	///   - isAdopted: A Boolean value indicating if the kitten is adopted.
	///   - microship: The microchip number of the kitten.
	///   - tattoo: The tattoo number of the kitten.
	///   - vaccines: A list of vaccines administered to the kitten.
	///   - adopters: The adopter of the kitten.
	///   - weightHistory: The weight history of the kitten.
	///   - isEdited: A Boolean value indicating if the kitten is being edited.
	///   - kittenId: The identifier of the kitten.
	///   - isAlive: A Boolean value indicating if the kitten is alive.
	/// - Returns: A composed `Kitten` object.
	func composeKitten(litter: Litter,
					   firstName: String?,
					   secondName: String?,
					   birthdate: Date?,
					   sex: String?,
					   color: String?,
					   rescueDate: Date?,
					   comment: String?,
					   isAdopted: Bool,
					   microship: Int?,
					   tattoo: String?,
					   vaccines: [Vaccine]?,
					   adopters: Adopter?,
					   weightHistory: [Weighing]?,
					   isEdited: Bool,
					   kittenId: String?,
					   isAlive: Bool) -> Kitten {
		
		let kitten = Kitten(id: isEdited ? kittenId : UUID().uuidString,
							litter: litter,
							firstName: firstName,
							secondName: secondName,
							birthdate: birthdate,
							sex: sex,
							color: color,
							rescueDate: rescueDate,
							siblings: litter.kittens?.filter { $0.firstName != firstName },
							comment: comment,
							isAdopted: isAdopted,
							microship: microship,
							tattoo: tattoo,
							vaccines: vaccines,
							adopters: adopters,
							weighingHistory: weightHistory,
							isAlive: isAlive)

		self.presenter.display(loader: false)
		return kitten
	}
	
	/// Saves the kitten details.
	/// - Parameters:
	///   - isNewKitten: A Boolean value indicating if the kitten is new.
	///   - kitten: The `Kitten` object to be saved.
	///   - litter: The `Litter` object associated with the kitten.
	func saveKitten(isNewKitten: Bool,
					kitten: Kitten,
					litter: Litter) {
		
		if isNewKitten {
			guard let newKitten = worker.createKitten(kitten: kitten, litter: litter) else {
				self.presenter.display(loader: false)
				return
			}
			
			self.presenter.display(loader: false)
			self.presenter.close()
			
			let userInfo: [AnyHashable: Any] = ["litterId": litter.id]
			NotificationCenter.default.post(name: NSNotification.Name("newKittenInLitter"), object: nil, userInfo: userInfo)
			
			let vc = LitterViewController.fromStoryboard { vc in
				vc.litterId = newKitten.litterId
				vc.isDisplayMode = true
				vc.isCreateMode = false
				vc.isEditMode = false
			}
			vc.push()
		} else {
			worker.updateKittenDB(kitten: kitten)
			self.presenter.display(loader: false)
			self.presenter.display(kitten: kitten)
			self.presenter.close()
		}
	}
}
