//  KittenCardViewController.swift
//
//  Created by Elora on 24/02/2023.
//

import UIKit
import UtilsKit

class KittenCardViewController: BaseViewController<KittenCardViewModel, KittenCardPresenter, KittenCardInteractor> {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var secondNameLabel: UILabel!
    @IBOutlet private weak var secondNameField: UITextField!
    @IBOutlet private weak var birthdateLabel: UILabel!
    @IBOutlet private weak var birthdateField: DatePickerField!
    @IBOutlet private weak var sexLabel: UILabel!
    @IBOutlet private weak var sexField: UITextField!
    @IBOutlet private weak var microshipLabel: UILabel!
    @IBOutlet private weak var microshipField: UITextField!
    @IBOutlet private weak var colorLabel: UILabel!
    @IBOutlet private weak var colorField: UITextField!
    
    @IBOutlet private weak var adoptersLabel: UILabel!
    @IBOutlet private weak var adopterField: UITextField!
    @IBOutlet private weak var siblingsLabel: UILabel!
    @IBOutlet private weak var siblingsField: UITextField!
    @IBOutlet private weak var rescueDateLabel: UILabel!
    @IBOutlet private weak var rescueDateField: DatePickerField!
    @IBOutlet private weak var commentsLabel: UILabel!
    @IBOutlet private weak var commentsField: UITextField!
    @IBOutlet private weak var weighingButton: UIButton!
    @IBOutlet private weak var weightHistory: UIView!
    @IBOutlet private weak var medicalHistory: UIView!
    @IBOutlet private weak var editBtn: UIButton!
    @IBOutlet private weak var saveBtn: UIButton!
    @IBOutlet private weak var adoptedBtn: UIButton!
    @IBOutlet private weak var deadBtn: UIButton!
    @IBOutlet private weak var validateModifiBtn: UIButton!
    // MARK: - Variables
    
    var litterId = ""
    var litter: Litter!
    var kitten: Kitten!
//    var kittenId: String = ""
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactor.refresh(kitten: self.kitten, litter: self.litter)
        
// MARK: labels
        
        self.nameLabel.text = self.viewModel.firtsNameLabel
        self.secondNameLabel.text = self.viewModel.secondNameLabel
        self.birthdateLabel.text = self.viewModel.birthdateLabel
        self.sexLabel.text = self.viewModel.sexLabel
        self.microshipLabel.text = self.viewModel.microshipLabel
        self.colorLabel.text = self.viewModel.colorLabel
        self.adoptersLabel.text = self.viewModel.adoptersLabel
        self.siblingsLabel.text = self.viewModel.siblingsLabel
        self.rescueDateLabel.text = self.viewModel.rescueDateLabel
        self.commentsLabel.text = self.viewModel.commentLabel
    }
    
    
    // MARK: - Refresh
    override func refreshUI() {
        super.refreshUI()
        
        self.nameField.text = self.viewModel.firstName
        self.nameField.isEnabled = false
        self.secondNameField.text = self.viewModel.secondName
        self.secondNameField.isEnabled = false
        self.birthdateField.text = self.viewModel.birthdate
        self.birthdateField.isEnabled = false
        self.sexField.text = self.viewModel.sex
        self.sexField.isEnabled = false
        self.microshipField.text = self.viewModel.microship
        self.microshipField.isEnabled = false
        self.colorField.text = self.viewModel.color
        self.colorField.isEnabled = false
        self.adopterField.text = self.viewModel.adopters
        self.adopterField.isEnabled = false
        self.siblingsField.text = self.viewModel.siblings
        self.siblingsField.isEnabled = false
        self.rescueDateField.text = self.viewModel.rescueDate
        self.rescueDateField.isEnabled = false
        self.commentsField.text = self.viewModel.comment
        self.commentsField.isEnabled = false
        
        self.saveBtn.isHidden = self.viewModel.validateCreationBtnHidden
        
        self.editBtn.isHidden = self.viewModel.editBtnHidden
        self.deadBtn.isHidden = self.viewModel.deadBtnHidden
        self.adoptedBtn.isHidden = self.viewModel.adopteBtnHidden
    }
    
    // MARK: - Actions
    
    
    @IBAction private func updateKitten() {
        let vc = KittenCardModalViewController.fromStoryboard()
        vc.litter = self.litter
        vc.isEditingMode = true
        vc.isCreatingMode = false
        
        navigationController?.present(vc, animated: true)
    }

    @IBAction private func edit() {
        let vc = KittenCardModalViewController.fromStoryboard()
        vc.litter = self.litter
        vc.kitten = self.kitten
        vc.isCreatingMode = false
        vc.isEditingMode = true
        navigationController?.present(vc, animated: true)
    }
    
    @IBAction private func adopte() {
    }
}

extension KittenCardViewController: StoryboardProtocol {
    static var storyboardName: String {
        "KittenCard"
    }
    
    static var identifier: String? {
        "KittenCardViewController"
    }
}
