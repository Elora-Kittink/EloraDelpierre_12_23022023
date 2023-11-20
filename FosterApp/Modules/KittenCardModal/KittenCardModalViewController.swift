//  KittenCardModalViewController.swift
//
//  Created by Elora on 03/04/2023.
//

import UIKit
import UtilsKit

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
	
    var litter: Litter!
	var isEditingMode: Bool!
    var isCreatingMode: Bool!
    var kitten: Kitten?
    
	// MARK: - View life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		self.interactor.refresh(isEdititngMode: isEditingMode, isCreatingMode: isCreatingMode, kitten: kitten)
        
        self.nameLabel.text = self.viewModel.firtsNameLabel
        self.secondNameLabel.text = self.viewModel.secondNameLabel
        self.birthdateLabel.text = self.viewModel.birthdateLabel
        self.sexLabel.text = self.viewModel.sexLabel
        self.microshipLabel.text = self.viewModel.microshipLabel
		self.tattooLabel.text = self.viewModel.tattooLabel
        self.colorLabel.text = self.viewModel.colorLabel
        self.adoptersLabel.text = self.viewModel.adoptersLabel
        self.rescueDateLabel.text = self.viewModel.rescueDateLabel
        self.commentsLabel.text = self.viewModel.commentLabel
		self.colorField.delegate = self
		
        self.title = self.isCreatingMode ? self.viewModel.newKittenTitle : self.viewModel.updateKittenTitle
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		AnalyticsManager.shared.log(event: .pageOpen, with: ["page": "\(Self.self)"])
	}
	
	// MARK: - Refresh
	override func refreshUI() {
//		Notification after saved new kitten or updated kitten
		let userInfo: [AnyHashable: Any] = ["kitten": self.viewModel.kitten]
        if self.viewModel.needToClose {
            self.dismiss(animated: true) {
				if self.isEditingMode {
					NotificationCenter.default.post(name: NSNotification.Name("kittenUpdated"), object: nil, userInfo: userInfo)
				} else {
					NotificationCenter.default.post(name: NSNotification.Name("newKittenCreated"), object: nil)
				}
            }
        }
		super.refreshUI()
        
        self.nameField.text = self.viewModel.firstName
        self.secondNameField.text = self.viewModel.secondName
        self.birthdateField.text = self.viewModel.birthdate
        self.sexField.selectedSegmentIndex = self.viewModel.sex
        self.microshipField.text = self.viewModel.microship
        self.colorField.text = self.viewModel.color
        self.adopterField.text = self.viewModel.adopters
        self.rescueDateField.text = self.viewModel.rescueDate
        self.commentsField.text = self.viewModel.comment
	}

	// MARK: - Actions
    
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

extension KittenCardModalViewController: StoryboardProtocol {
    static var storyboardName: String {
        "KittenCardModal"
    }
    
    static var identifier: String? {
        "KittenCardModalViewController"
    }
}

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
