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
    var isEditingMode = false
    var isCreatingMode = false
    var kitten: Kitten?
    
	// MARK: - View life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		print("👹 litter \(litter)")
        self.interactor.refresh(isEdititngMode: isEditingMode, isCreatingMode: isCreatingMode, kitten: kitten)
        
        self.nameLabel.text = self.viewModel.firtsNameLabel
        self.secondNameLabel.text = self.viewModel.secondNameLabel
        self.birthdateLabel.text = self.viewModel.birthdateLabel
        self.sexLabel.text = self.viewModel.sexLabel
        self.microshipLabel.text = self.viewModel.microshipLabel
        self.colorLabel.text = self.viewModel.colorLabel
        self.adoptersLabel.text = self.viewModel.adoptersLabel
        self.rescueDateLabel.text = self.viewModel.rescueDateLabel
        self.commentsLabel.text = self.viewModel.commentLabel
	}
	
	// MARK: - Refresh
	override func refreshUI() {
        if self.viewModel.needToClose {
            self.dismiss(animated: true) {
                NotificationCenter.default.post(name: NSNotification.Name("newKittenCreated"), object: nil)
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
//        TODO: kittenId = nil? Mais comment il update du coup? vérifier que ça marche
        let kitten = self.interactor.composeKitten(litter: self.litter,
                                                   firstName: self.nameField.text ?? "",
                                                   secondName: self.secondNameField.text,
                                                   birthdate: self.birthdateField.text?.toDate(format: "dd/MM/yyyy"),
                                                   sex: self.sexField.titleForSegment(at: self.sexField.selectedSegmentIndex),
                                                   color: self.colorField.text,
                                                   rescueDate: self.rescueDateField.text?.toDate(format: "dd/MM/yyyy") ?? Date(),
                                                   comment: self.commentsField.text,
                                                   isAdopted: false,
                                                   microship: Int(self.microshipField.text ?? ""),
                                                   vaccines: nil,
                                                   adopters: nil,
                                                   weightHistory: nil,
                                                   isEdited: false,
                                                   kittenId: nil,
                                                   isAlive: true)
        
        self.interactor.saveKitten(isNewKitten: isCreatingMode, kitten: kitten, litter: litter)
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
