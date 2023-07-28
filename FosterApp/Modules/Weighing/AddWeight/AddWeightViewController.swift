//  AddWeightViewController.swift
//
//  Created by Elora on 09/07/2023.
//

import UIKit

class AddWeightViewController: BaseViewController
<
	AddWeightViewModel,
	AddWeightPresenter,
	AddWeightInteractor
> {
	
	// MARK: - Outlets
	@IBOutlet private weak var kittenWeightLabel: UILabel!
	@IBOutlet private weak var kittenWeightTF: UITextField!
	@IBOutlet private weak var mealWeightLabel: UILabel!
	@IBOutlet private weak var mealWeightTF: UITextField!
	
	// MARK: - Variables
	
	var kitten: Kitten!
	var weighing: Weighing?
	var isEditingMode = false
	
	// MARK: - View life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		self.mealWeightLabel.text = self.viewModel.mealWeightLabel
		self.kittenWeightLabel.text = self.viewModel.kittenWeightLabel
	}
	
	// MARK: - Refresh
	override func refreshUI() {
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
	
	@IBAction private func didTapValidateButton() {
		let weighing = self.interactor.composeWeighing(weightId: weighing?.id,
													   kittenWeight: Doub,
													   mealWeight: self.mealWeightTF.text,
													   date: Date(),
													   isEdition: self.isEditingMode)
		
		self.interactor.saveWeighing(isNew: !isEditingMode, weighing: weighing, kitten: self.kitten)
	}
}
