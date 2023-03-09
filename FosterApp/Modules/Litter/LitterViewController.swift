//  LitterViewController.swift
//
//  Created by Elora on 24/02/2023.
//

import UIKit

class LitterViewController: BaseViewController<LitterViewModel,LitterPresenter,LitterInteractor> {
	
	// MARK: - Outlets
	
    @IBOutlet weak var litterTable: UITableView!
    @IBOutlet weak var addKittenButton: AddButton!
    @IBOutlet weak var rescueDateTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var archiveButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    // MARK: - Variables
    
    let litterId: String = ""
    
	// MARK: - View life cycle
    
	override func viewDidLoad() {
		super.viewDidLoad()
        self.interactor.refresh(litterId: litterId)
	}
	
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
    
        self.rescueDateTextField.isEnabled = self.viewModel.isTextFieldEnable
        self.saveButton.isHidden = self.viewModel.saveBtnHidden
        self.editButton.isHidden = self.viewModel.editBtnHidden
        self.archiveButton.isHidden = self.viewModel.archiveBtnHidden
        self.favoriteButton.isHidden = self.viewModel.favoriteBtnHidden
        self.addKittenButton.isHidden = self.viewModel.addKittenBtnHidden
	}

	// MARK: - Actions
    @IBAction func makeItOngoing() {
        
    }
    @IBAction func addKitten(litterId: String) {
        
        let vc = KittenCardViewController.fromStoryboard()
        vc.litterId = self.viewModel.id
        vc.newKittenCreation = true
        
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func archiveLitter() {
        self.interactor.archiveLitter(litterId: self.viewModel.id)
    }
    @IBAction func editLitter() {
        
    }
    @IBAction func save() {
    }
}

//   trois versions :
//  une affichant la portée, bouton "save" caché, textField disable
//  une édition avec textField enable et bouton "save" visible, bouton éditer caché, bouton archivé caché, bouton ajout chaton caché
//  une de création de nouvelle portée avec textField vide enable, bouton "save" visible, bouton archiver caché, bouton ajouter chaton caché, bouton éditer caché
