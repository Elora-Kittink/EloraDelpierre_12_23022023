//  AddWeightInteractor.swift
//
//  Created by Elora on 09/07/2023.
//

import Foundation

/// `AddWeightInteractor` handles the business logic for the `AddWeightViewController`.
/// It is responsible for composing and saving weighing instances.
class AddWeightInteractor: Interactor
<
	AddWeightViewModel,
	AddWeightPresenter
> {
	let worker = DBWorker()
	
	/// Creates an instance of `Weighing` from form data.
	func composeWeighing(weightId: String?,
						 kittenWeight: String?,
						 mealWeight: String?,
						 date: Date,
						 isEdition: Bool) -> Weighing {
		// Implementation for composing weighing
        self.presenter.display(loader: false)
		return Weighing(id: isEdition ? weightId : UUID().uuidString,
						date: date,
						kittenWeight: kittenWeight ?? "",
						mealWeight: mealWeight ?? "")
	}
	
	/// Creates or updates a weighing in the database.
	func saveWeighing(isNew: Bool,
					  weighing: Weighing,
					  kitten: Kitten) {
		
		if isNew {
			worker.createWeighing(kitten: kitten,
								  weighing: weighing)
		} else {
			worker.updateWeighing(weighing: weighing)
		}
		self.presenter.display(loader: false)
		self.presenter.close()
	}
}
