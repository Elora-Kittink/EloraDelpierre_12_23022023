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
    var kitten: Kitten? {
        didSet {
            self.interactor.refresh(isEditingMode: false, isCreatingMode: false, isDisplayingMode: true, litter: self.litter, kittenId: self.kitten?.id, kitten: self.kitten)
        }
    }
    var kittenId: String = ""
    var isEditingMode = false
    var isDisplayingMode = true
    var isCreatingMode = false
    
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.interactor.refresh(isEditingMode: self.isEditingMode,
                                isCreatingMode: self.isCreatingMode,
                                isDisplayingMode: self.isDisplayingMode,
                                litter: litter,
                                kittenId: kittenId,
                                kitten: nil)
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
//        self.validateModifiBtn.isHidden = self.viewModel.validateModifBtnHidden
    }
    
    // MARK: - Actions
    
    
    @IBAction private func updateKitten() {
        let vc = KittenCardModalViewController.fromStoryboard()
        vc.kittenId = self.kittenId
//        vc.litterId = self.litterId
        vc.litter = self.litter
        vc.isEditingMode = true
        vc.isCreatingMode = false
        
        navigationController?.present(vc, animated: true)
    }
    
    @IBAction private func save() {
        
        let kitten = self.interactor.composeKitten(litter: self.litter,
                                                   firstName: self.nameField.text ?? "",
                                                   secondName: self.secondNameField.text,
                                                   birthdate: self.birthdateField.text?.toDate(format: "dd/MM/yyyy"),
                                                   sex: self.sexField.text,
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
        
        self.interactor.refresh(isEditingMode: self.isEditing,
                                isCreatingMode: self.isCreatingMode,
                                isDisplayingMode: self.isDisplayingMode,
                                litter: self.litter,
                                kittenId: kitten.id,
                                kitten: kitten)
    }
    
    
    @IBAction private func edit() {
        self.interactor.refresh(isEditingMode: true,
                                isCreatingMode: false,
                                isDisplayingMode: false,
                                litter: self.litter,
                                kittenId: self.kittenId,
                                kitten: self.viewModel.kitten)
    }
    
    @IBAction private func saveModifications() {
        let kittenModified = self.interactor.composeKitten(litter: self.litter,
                                                           firstName: self.nameField.text ?? "",
                                                           secondName: self.secondNameField.text,
                                                           birthdate: self.birthdateField.text?.toDate(format: "dd/MM/yyyy"),
                                                           sex: self.sexField.text,
                                                           color: self.colorField.text,
                                                           rescueDate: self.rescueDateField.text?.toDate(format: "dd/MM/yyyy") ?? Date(),
                                                           comment: self.commentsField.text,
                                                           isAdopted: false,
                                                           microship: Int(self.microshipField.text ?? ""),
                                                           vaccines: nil,
                                                           adopters: nil,
                                                           weightHistory: nil,
                                                           isEdited: true,
                                                           kittenId: self.viewModel.kitten?.id,
                                                           isAlive: true)
        
        self.interactor.worker.updateKittenDB(kitten: kittenModified)
        
        self.interactor.refresh(isEditingMode: self.isEditing,
                                isCreatingMode: self.isCreatingMode,
                                isDisplayingMode: self.isDisplayingMode,
                                litter: self.litter,
                                kittenId: kittenModified.id,
                                kitten: kittenModified)
    }
    
    @IBAction private func dead() {
        let kittenKilled = self.interactor.composeKitten(litter: self.litter,
                                                           firstName: self.nameField.text ?? "",
                                                           secondName: self.secondNameField.text,
                                                           birthdate: self.birthdateField.text?.toDate(format: "dd/MM/yyyy"),
                                                           sex: self.sexField.text,
                                                           color: self.colorField.text,
                                                           rescueDate: self.rescueDateField.text?.toDate(format: "dd/MM/yyyy") ?? Date(),
                                                           comment: self.commentsField.text,
                                                           isAdopted: false,
                                                           microship: Int(self.microshipField.text ?? ""),
                                                           vaccines: nil,
                                                           adopters: nil,
                                                           weightHistory: nil,
                                                           isEdited: true,
                                                           kittenId: self.viewModel.kitten?.id,
                                                           isAlive: false)
        
        self.interactor.worker.updateKittenDB(kitten: kittenKilled)
        
        self.interactor.refresh(isEditingMode: self.isEditing,
                                isCreatingMode: self.isCreatingMode,
                                isDisplayingMode: self.isDisplayingMode,
                                litter: self.litter,
                                kittenId: kittenKilled.id,
                                kitten: kittenKilled)
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
