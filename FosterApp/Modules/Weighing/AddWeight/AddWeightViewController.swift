//  AddWeightViewController.swift
//
//  Created by Elora on 09/07/2023.
//

import UIKit
import UtilsKit

/// `AddWeightViewController` manages the user interface for adding or editing a kitten's weight and meal weight.
/// It allows users to input weight data and handles the saving of this data.
/// This controller inherits from `BaseViewController` and is specialized with `AddWeightViewModel`, 
/// `AddWeightPresenter`, and `AddWeightInteractor` for its operation.
class AddWeightViewController: BaseViewController
<
	AddWeightViewModel,
	AddWeightPresenter,
	AddWeightInteractor
> {
	
	// MARK: - Outlets
	
	/// Label displaying the kitten weight field description.
	@IBOutlet private weak var kittenWeightLabel: UILabel!
	/// TextField for entering the kitten's weight.
	@IBOutlet private weak var kittenWeightTF: UITextField!
	/// Label displaying the meal weight field description.
	@IBOutlet private weak var mealWeightLabel: UILabel!
	/// TextField for entering the meal's weight.
	@IBOutlet private weak var mealWeightTF: UITextField!
	
	// MARK: - Variables
	
	/// The kitten object for which the weight is being added or edited.
	var kitten: Kitten!
	/// The current weighing object being edited, if applicable.
	var weighing: Weighing?
	/// Flag indicating whether the view is in editing mode.
	var isEditingMode = false
	
	// MARK: - View life cycle
	
	/// Called after the controller's view is loaded into memory.
	override func viewDidLoad() {
		super.viewDidLoad()
		// Additional setup after loading the view
		self.mealWeightLabel.text = self.viewModel.mealWeightLabel
		self.kittenWeightLabel.text = self.viewModel.kittenWeightLabel
		
        self.title = self.isEditingMode ? self.viewModel.updateWeighingTitle : self.viewModel.newWeighingTitle
	}
	
	/// Logs a page open event when the view appears.
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		AnalyticsManager.shared.log(event: .pageOpen, with: ["page": "\(Self.self)"])
	}
	
	// MARK: - Refresh
	
	/// Refreshes the user interface with the new data stored in the ViewModel.
	/// Closes the view controller if necessary and posts a notification for a new weighing creation.
	override func refreshUI() {
		// Implementation for refreshing UI
		if self.viewModel.needToClose {
			self.dismiss(animated: true) {
				NotificationCenter.default.post(name: NSNotification.Name("newWeighingCreated"), object: nil)
			}
		}
		super.refreshUI()
		self.kittenWeightTF.text = self.viewModel.kittenWeight
		self.mealWeightTF.text = self.viewModel.mealWeight
	}

	// MARK: - Actions
	
	/// Handles the action when the validate button is tapped.
	/// Composes a weighing instance and requests the interactor to save it.
	@IBAction private func didTapValidateButton() {
		// Implementation for handling the validate button action
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name": "validate"])
		
		let weighing = self.interactor.composeWeighing(weightId: weighing?.id,
													   kittenWeight: self.kittenWeightTF.text,
													   mealWeight: self.mealWeightTF.text,
													   date: Date(),
													   isEdition: self.isEditingMode)
		
		self.interactor.saveWeighing(isNew: !isEditingMode, weighing: weighing, kitten: self.kitten)
	}
}

// MARK: - StoryboardProtocol

/// Extension conforming to StoryboardProtocol for storyboard-based instantiation.
extension  AddWeightViewController: StoryboardProtocol {
	static var storyboardName: String {
		"AddWeight"
	}
	
	static var identifier: String? {
		"AddWeightViewController"
	}
}
