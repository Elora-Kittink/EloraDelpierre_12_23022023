//  AddWeightInteractor.swift
//
//  Created by Elora on 09/07/2023.
//

import Foundation

class AddWeightInteractor: Interactor
<
	AddWeightViewModel,
	AddWeightPresenter
> {
	let worker = DBWorker()
	
	func composeWeighing(weightId: String?,
						 kittenWeight: String?,
						 mealWeight: String?,
						 date: Date,
						 isEdition: Bool) -> Weighing {
		
        self.presenter.display(loader: false)
		return Weighing(id: isEdition ? weightId : UUID().uuidString,
						date: date,
						kittenWeight: kittenWeight ?? "",
						mealWeight: mealWeight ?? "")
	}
	
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
