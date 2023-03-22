//  LitterViewController.swift
//
//  Created by Elora on 24/02/2023.
//

import UIKit
import UtilsKit

class LitterViewController: BaseViewController<LitterViewModel,LitterPresenter,LitterInteractor> {
	
	// MARK: - Outlets
	
    @IBOutlet weak var litterTable: UITableView!
    @IBOutlet weak var addKittenButton: UIButton!
    @IBOutlet weak var rescueDateTextField: DatePickerField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var archiveButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Variables
    
    var litterId: String? {
        didSet {
            self.interactor.refresh(isEditing: isEditMode, isCreating: isCreateMode, isDisplaying: isDisplayMode, litterId: litterId, rescueDate: nil)
        }
    }
    var isCreateMode: Bool = false
    var isDisplayMode: Bool = true
    var isEditMode: Bool = false
    
	// MARK: - View life cycle
    
	override func viewDidLoad() {
		super.viewDidLoad()
        self.litterTable.delegate = self
        self.litterTable.dataSource = self
        self.interactor.diplayMode(isEditing: isEditMode, isCreating: isCreateMode, isDisplaying: isDisplayMode, litterId: litterId)
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
        self.rescueDateTextField.text = self.viewModel.rescueDate
        litterTable.reloadData()
	}

	// MARK: - Actions
    @IBAction func makeItFavorite() {
        guard let litterId = litterId else { return }
        self.interactor.makeFavorite(litterId: litterId)
    }
    
    @IBAction func addKitten() {
        
        let vc = KittenCardViewController.fromStoryboard()
        vc.litterId = self.viewModel.id
        vc.litter = self.viewModel.litter
        vc.isCreatingMode = true
        vc.isEditingMode = false
        vc.isDisplayingMode = false
        
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func archiveLitter() {
        self.interactor.archiveLitter(litterId: self.viewModel.id)
    }
    
    @IBAction func editLitter() {
        self.interactor.diplayMode(isEditing: true, isCreating: false, isDisplaying: false
                                   , litterId: litterId)
    }
    

    @IBAction func save() {
        self.interactor.refresh(isEditing: self.viewModel.isEditing, isCreating: self.viewModel.isCreatingNew, isDisplaying: self.viewModel.isDisplaying, litterId: self.viewModel.id, rescueDate: rescueDateTextField.text?.toDate(format: "dd/MM/yyyy"))
    }
    
    @objc func validateAndDismiss(){
        view.endEditing(true)
        
        self.interactor.displayDate(date: self.rescueDateTextField.text?.toDate(format: "dd/MM/yyyy") ?? Date())
    }
}

extension LitterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        min(tableView.frame.height / 1.5, 50)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let kittens = self.viewModel.kittens else {
            return 0
        }
       return kittens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "litterCell", for: indexPath)
        
        cell.textLabel?.text = self.viewModel.kittens?[indexPath.row].firstName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let kittenId = self.viewModel.kittens?[indexPath.row].id else {
            return
        }
        let vc = KittenCardViewController.fromStoryboard()
        vc.litterId = self.viewModel.id
        vc.kittenId = kittenId
        vc.litter = self.viewModel.litter
        vc.isDisplayingMode = true
        vc.isEditingMode = false
        vc.isCreatingMode = false
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LitterViewController: StoryboardProtocol {
    static var storyboardName: String {
        "Litter"
    }
    
    static var identifier: String? {
        "LitterViewController"
    }
}
