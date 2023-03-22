//  KittenCardViewController.swift
//
//  Created by Elora on 24/02/2023.
//

import UIKit
import UtilsKit

class KittenCardViewController: BaseViewController<KittenCardViewModel,KittenCardPresenter,KittenCardInteractor> {
	
	// MARK: - Outlets
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var secondNameField: UITextField!
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var birthdateField: DatePickerField!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var sexField: UITextField!
    @IBOutlet weak var microshipLabel: UILabel!
    @IBOutlet weak var microshipField: UITextField!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var colorField: UITextField!
//    TODO: le champs adopter n'a pas besoin d'être modifié directement dans le champs
    @IBOutlet weak var adoptersLabel: UILabel!
    @IBOutlet weak var adopterField: UITextField!
    //    TODO: le champs siblings n'a pas besoin d'être modifié directement dans le champs
    @IBOutlet weak var siblingsLabel: UILabel!
    @IBOutlet weak var siblingsField: UITextField!
    @IBOutlet weak var rescueDateLabel: UILabel!
    @IBOutlet weak var rescueDateField: DatePickerField!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var commentsField: UITextField!
    @IBOutlet weak var weighingButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var weightHistory: UIView!
    @IBOutlet weak var medicalHistory: UIView!

    
    // MARK: - Variables
    
    var litterId = ""
    var litter: Litter!
    var kittenId: String = ""
    var isEditingMode: Bool = false
    var isDisplayingMode: Bool = true
    var isCreatingMode: Bool = false
    private let datePicker = UIDatePicker()

    
	// MARK: - View life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
//     MARK: date picker
//        TODO: probleme avec le double datepicker, marche pas pour la date de sauvetage
//        let toolBar = UIToolbar()
//        let validate = UIBarButtonItem(title: "Valider", style: .plain, target: self, action: #selector(self.validateAndDismiss))
//        datePicker.datePickerMode = .date
//        datePicker.frame.size = CGSize(width: 0, height: 300)
//        datePicker.preferredDatePickerStyle = .wheels
//        toolBar.items = [validate]
//        toolBar.sizeToFit()
//        birthdateField.inputAccessoryView = toolBar
//        rescueDateField.inputAccessoryView = toolBar
//        birthdateField.inputView = datePicker
//        rescueDateField.inputView = datePicker
        
//        MARK: labels
        
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

        self.interactor.refresh(isEditingMode: self.isEditingMode, isCreatingMode: self.isCreatingMode, isDisplayingMode: isDisplayingMode, litter: litter, kittenId: kittenId, kitten: nil)
    }
    
    
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()

        self.nameField.text = self.viewModel.firstName
        self.nameField.isEnabled = self.viewModel.textFieldsEnable
        self.secondNameField.text = self.viewModel.secondName
        self.secondNameField.isEnabled = self.viewModel.textFieldsEnable
        self.birthdateField.text = self.viewModel.birthdate
        self.birthdateField.isEnabled = self.viewModel.textFieldsEnable
        self.sexField.text = self.viewModel.sex
        self.sexField.isEnabled = self.viewModel.textFieldsEnable
        self.microshipField.text = self.viewModel.microship
        self.microshipField.isEnabled = self.viewModel.textFieldsEnable
        self.colorField.text = self.viewModel.color
        self.colorField.isEnabled = self.viewModel.textFieldsEnable
        self.adopterField.text = self.viewModel.adopters
        self.adopterField.isEnabled = false
        self.siblingsField.text = self.viewModel.siblings
        self.siblingsField.isEnabled = false
        self.rescueDateField.text = self.viewModel.rescueDate
        self.rescueDateField.isEnabled = self.viewModel.textFieldsEnable
        self.commentsField.text = self.viewModel.comment
        self.commentsField.isEnabled = self.viewModel.textFieldsEnable
	}

	// MARK: - Actions
    @IBAction func save() {

     let kitten = self.interactor.createKitten(litter: self.litter,
                                     firstName: self.nameField.text ?? "",
                                     secondName: self.secondNameField.text,
                                     birthdate:  self.birthdateField.text?.toDate(format: "dd/MM/yyyy"),
                                     sex: self.sexField.text,
                                     color: self.colorField.text,
                                     rescueDate: self.rescueDateField.text?.toDate(format: "dd/MM/yyyy") ?? Date(),
                                     comment: self.commentsField.text,
                                     isAdopted: false,
                                     microship: Int(self.microshipField.text ?? ""),
                                     vaccines: nil,
                                     adopters: nil,
                                     weightHistory: nil)
        
        self.interactor.refresh(isEditingMode: self.isEditing,
                                isCreatingMode: self.isCreatingMode,
                                isDisplayingMode: self.isDisplayingMode,
                                litter: self.litter,
                                kittenId: kitten.id,
                                kitten: kitten)
    }
    
    @IBAction func edit() {
        
    }
    

    @IBAction func dead() {
    }
    
    @IBAction func adopte() {
    }
    
//    @objc func validateAndDismiss() {
//
////     TODO:   mettre en place un sender pour savoir de quel textefield ça vient?
//
//        if self.birthdateField.isFirstResponder {
//            self.interactor.displayDate(date: self.datePicker.date, sender: birthdateField)
//        }
//        if self.rescueDateField.isFirstResponder {
//            self.interactor.displayDate(date: self.datePicker.date, sender: rescueDateField)
//        }
//        view.endEditing(true)
//    }

    
}

extension KittenCardViewController: StoryboardProtocol {
    static var storyboardName: String {
        "KittenCard"
    }
    
    static var identifier: String? {
        "KittenCardViewController"
    }
}
