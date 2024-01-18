//  AddWeightViewModel.swift
//
//  Created by Elora on 09/07/2023.
//

/// `AddWeightViewModel` represents the state and data of the `AddWeightViewController`.
class AddWeightViewModel: ViewModel {
	
	/// Label for the kitten weight field.
	var kittenWeightLabel = "Chaton"
	/// Label for the meal weight field.
	var mealWeightLabel = "Lait"
	/// Stored value for kitten weight input field.
	var kittenWeight: String = ""
	/// Stored value for meal weight input field.
	var mealWeight: String = ""
	/// Title for new weighing creation.
    let newWeighingTitle = "Nouvelle pesée"
	/// Title for editing an existing weighing.
    let updateWeighingTitle = "Modifier la pesée"
}
