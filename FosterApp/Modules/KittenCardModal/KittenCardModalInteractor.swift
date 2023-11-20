//  KittenCardModalInteractor.swift
//
//  Created by Elora on 03/04/2023.
//

import Foundation

class KittenCardModalInteractor: Interactor
<
	KittenCardModalViewModel,
	KittenCardModalPresenter
> {
	
	let worker = DBWorker()
	
	func refresh(isEdititngMode: Bool, isCreatingMode: Bool, kitten: Kitten?) {
		
		if isEdititngMode {
			self.presenter.display(kitten: kitten)
		}
		if isCreatingMode {
			self.presenter.display(kitten: nil)
		}
		self.presenter.display(loader: false)
	}
	
	
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
					   tattoo: String,
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
		print("🐞 id composed = \(kitten.id)")
		self.presenter.display(loader: false)
		return kitten
	}
	
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
