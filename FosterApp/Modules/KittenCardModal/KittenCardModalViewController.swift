//  KittenCardModalViewController.swift
//
//  Created by Elora on 03/04/2023.
//

import UIKit
import UtilsKit

/// A view controller that manages the modal presentation for creating or editing a kitten's details.
/// This controller inherits from `BaseViewController` and is specialized with `KittenCardModalIconViewModel`, 
/// `KittenCardModalPresenter`, and `KittenCardModalInteractor` for its operation.
class KittenCardModalViewController: BaseViewController
<
	KittenCardModalViewModel,
	KittenCardModalPresenter,
	KittenCardModalInteractor
> {
	
	// MARK: - Outlets
	
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var secondNameLabel: UILabel!
    @IBOutlet private weak var secondNameField: UITextField!
    @IBOutlet private weak var birthdateLabel: UILabel!
    @IBOutlet private weak var birthdateField: DatePickerField!
    @IBOutlet private weak var sexLabel: UILabel!
    @IBOutlet private weak var sexField: UISegmentedControl!
    @IBOutlet private weak var microshipLabel: UILabel!
    @IBOutlet private weak var microshipField: UITextField!
	@IBOutlet private weak var tattooLabel: UILabel!
	@IBOutlet private weak var tattooField: UITextField!
    @IBOutlet private weak var colorLabel: UILabel!
    @IBOutlet private weak var colorField: UITextField!
    @IBOutlet private weak var adoptersLabel: UILabel!
    @IBOutlet private weak var adopterField: UITextField!
    @IBOutlet private weak var rescueDateLabel: UILabel!
    @IBOutlet private weak var rescueDateField: DatePickerField!
    @IBOutlet private weak var commentsLabel: UILabel!
    @IBOutlet private weak var commentsField: UITextField!
    
	// MARK: - Variables
	
	/// The litter associated with the kitten.
    var litter: Litter!
	/// Indicates if the view controller is in editing mode.
	var isEditingMode: Bool!
	/// Indicates if the view controller is in creating mode.
    var isCreatingMode: Bool!
	/// The kitten being created or edited.
    var kitten: Kitten?
    
	// MARK: - View life cycle
	
	/// Called after the controller's view is loaded into memory.
	override func viewDidLoad() {
		super.viewDidLoad()
		self.interactor.refresh(isEdititngMode: isEditingMode, isCreatingMode: isCreatingMode, kitten: kitten)
        
		self.view.hideKeyboardOnTap()
		
        self.nameLabel.text = self.viewModel.firtsNameLabel
		self.nameLabel.isAccessibilityElement = false
        self.secondNameLabel.text = self.viewModel.secondNameLabel
		self.secondNameLabel.isAccessibilityElement = false
        self.birthdateLabel.text = self.viewModel.birthdateLabel
		self.birthdateLabel.isAccessibilityElement = false
        self.sexLabel.text = self.viewModel.sexLabel
		self.sexLabel.isAccessibilityElement = false
        self.microshipLabel.text = self.viewModel.microshipLabel
		self.microshipLabel.isAccessibilityElement = false
		self.tattooLabel.text = self.viewModel.tattooLabel
		self.tattooLabel.isAccessibilityElement = false
        self.colorLabel.text = self.viewModel.colorLabel
		self.colorLabel.isAccessibilityElement = false
        self.adoptersLabel.text = self.viewModel.adoptersLabel
		self.adoptersLabel.isAccessibilityElement = false
        self.rescueDateLabel.text = self.viewModel.rescueDateLabel
		self.rescueDateLabel.isAccessibilityElement = false
        self.commentsLabel.text = self.viewModel.commentLabel
		self.commentsLabel.isAccessibilityElement = false
		self.colorField.delegate = self
		
		self.nameField.accessibilityLabel = self.nameLabel.text
		self.secondNameField.accessibilityLabel = self.secondNameLabel.text
		self.birthdateField.accessibilityLabel = self.birthdateLabel.text
		self.microshipField.accessibilityLabel = self.microshipLabel.text
		self.tattooField.accessibilityLabel = self.tattooLabel.text
		self.colorField.accessibilityLabel = self.colorLabel.text
		self.adopterField.accessibilityLabel = self.adoptersLabel.text
		self.rescueDateField.accessibilityLabel = self.rescueDateLabel.text
		self.commentsField.accessibilityLabel = self.commentsLabel.text
		
        self.title = self.isCreatingMode ? self.viewModel.newKittenTitle : self.viewModel.updateKittenTitle
	}
	
	/// Called when the view has appeared on the screen.
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		AnalyticsManager.shared.log(event: .pageOpen, with: ["page": "\(Self.self)"])
	}
	
	// MARK: - Refresh

	/// Refreshes the UI with new data stored in the ViewModel.
	override func refreshUI() {
//		Notification after saved new kitten or updated kitten
		
		if let kitten = self.viewModel.kitten {
			let userInfo: [AnyHashable: Any] = ["kitten": kitten]
			if self.viewModel.needToClose {
				self.dismiss(animated: true) {
					if self.isEditingMode {
						NotificationCenter.default.post(name: NSNotification.Name("kittenUpdated"), object: nil, userInfo: userInfo)
					}
				}
			}
		}
		super.refreshUI()
        
        self.nameField.text = self.viewModel.firstName
        self.secondNameField.text = self.viewModel.secondName
        self.birthdateField.text = self.viewModel.birthdate
        self.sexField.selectedSegmentIndex = self.viewModel.sex
        self.microshipField.text = self.viewModel.microship
		self.tattooField.text = self.viewModel.tattoo
        self.colorField.text = self.viewModel.color
        self.adopterField.text = self.viewModel.adopters
        self.rescueDateField.text = self.viewModel.rescueDate
        self.commentsField.text = self.viewModel.comment
	}

	// MARK: - Actions
    
	/// Action for saving the kitten's details.
    @IBAction private func save() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name": "save"])

        let kittenComposed = self.interactor.composeKitten(litter: self.litter,
                                                   firstName: self.nameField.text ?? "",
                                                   secondName: self.secondNameField.text,
                                                   birthdate: self.birthdateField.text?.toDate(format: "dd/MM/yyyy"),
                                                   sex: self.sexField.titleForSegment(at: self.sexField.selectedSegmentIndex),
                                                   color: self.colorField.text,
                                                   rescueDate: self.rescueDateField.text?.toDate(format: "dd/MM/yyyy") ?? Date(),
                                                   comment: self.commentsField.text,
                                                   isAdopted: false,
												   microship: Int(self.microshipField.text ?? ""),
												   tattoo: self.tattooField.text ?? "",
                                                   vaccines: nil,
                                                   adopters: nil,
                                                   weightHistory: nil,
                                                   isEdited: isEditingMode,
												   kittenId: self.kitten?.id,
                                                   isAlive: true)
        
        self.interactor.saveKitten(isNewKitten: isCreatingMode, kitten: kittenComposed, litter: litter)
        self.interactor.refresh(isEdititngMode: self.isEditing,
                                isCreatingMode: self.isCreatingMode,
                                kitten: kitten)
    }
}

// MARK: - Storyboard Protocol Conformance

extension KittenCardModalViewController: StoryboardProtocol {
    static var storyboardName: String {
        "KittenCardModal"
    }
    
    static var identifier: String? {
        "KittenCardModalViewController"
    }
}

// MARK: - UITextFieldDelegate Conformance

extension KittenCardModalViewController: UITextFieldDelegate {
//	limit the number of characters for "color" textfield
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		guard let text = textField.text else {
			return false
		}
		let NStext = (text as NSString).replacingCharacters(in: range, with: string)
		return NStext.count <= 25
	}
}
