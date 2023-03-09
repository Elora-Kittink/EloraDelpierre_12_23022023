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
    @IBOutlet weak var birthdateField: UITextField!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var sexField: UITextField!
    @IBOutlet weak var microshipLabel: UILabel!
    @IBOutlet weak var microshipField: UITextField!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var colorField: UITextField!
    @IBOutlet weak var adoptersLabel: UILabel!
    @IBOutlet weak var adopterField: UITextField!
    @IBOutlet weak var siblingsLabel: UILabel!
    @IBOutlet weak var siblingsField: UITextField!
    @IBOutlet weak var rescueDateLabel: UILabel!
    @IBOutlet weak var rescueDateField: UITextField!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var commentsField: UITextField!
    @IBOutlet weak var weighingButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var weightHistory: UIView!
    @IBOutlet weak var medicalHistory: UIView!

    
    // MARK: - Variables
    
    var litterId = ""
    var kittenId: String = ""
    var newKittenCreation: Bool = false
	
	// MARK: - View life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
        
	}
	
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        self.interactor.refresh(newKittenCreation: newKittenCreation, kittenId: self.viewModel.id)
    }
    
    
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
        self.nameField.text = self.viewModel.firstName
        self.nameField.isEnabled = self.viewModel.isFieldsEnabled
        self.secondNameField.text = self.viewModel.secondName
        self.secondNameField.isEnabled = self.viewModel.isFieldsEnabled
        self.birthdateField.text = self.viewModel.birthdate
        self.sexField.text = self.viewModel.sex
        self.microshipField.text = self.viewModel.microship
        self.colorField.text = self.viewModel.color
        self.adopterField.text = self.viewModel.adopters
        self.siblingsField.text = self.viewModel.siblings
        self.rescueDateField.text = self.viewModel.rescueDate
        self.commentsField.text = self.viewModel.comment
	}

	// MARK: - Actions
}

extension KittenCardViewController: StoryboardProtocol {
    static var storyboardName: String {
        "KittenCard"
    }
    
    static var identifier: String? {
        "KittenCardViewController"
    }
}
