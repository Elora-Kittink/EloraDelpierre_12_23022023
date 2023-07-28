//  LitterViewController.swift
//
//  Created by Elora on 24/02/2023.
//

import UIKit
import UtilsKit

class LitterViewController: BaseViewController<LitterViewModel, LitterPresenter, LitterInteractor> {
	
	// MARK: - Outlets
	
//    @IBOutlet private weak var litterTable: UITableView!
    @IBOutlet private weak var addKittenButton: UIButton!
    @IBOutlet private weak var rescueDateTextField: DatePickerField!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var editButton: UIButton!
    @IBOutlet private weak var archiveButton: UIButton!
    @IBOutlet private weak var favoriteButton: UIButton!
	@IBOutlet private weak var topView: UIView!
	
    // MARK: - Variables
    
    var litterId: String? {
        didSet {
            self.interactor.refresh(litterId: litterId)
        }
    }
    var isCreateMode = false
    var isDisplayMode = true
    var isEditMode = false
    var user: User!
	
	lazy var  litterTableView: BaseTableView<KittenCell, Kitten> = {
	let litterTableView =  BaseTableView <KittenCell, Kitten>(didSelect: didSelect(item: at: ))
	return litterTableView
	}()
	
	
	// MARK: - View life cycle
    
	override func viewDidLoad() {
		super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("newKittenCreated"),
                                               object: nil,
                                               queue: nil) { [interactor] _ in
            interactor.refresh(litterId: self.litterId)
        }
		self.setupTableViewUI()
		
//        self.litterTable.delegate = self
//        self.litterTable.dataSource = self
        self.interactor.diplayMode(isEditing: isEditMode,
                                   isCreating: isCreateMode,
                                   isDisplaying: isDisplayMode,
                                   litterId: litterId)
	}
	
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
		litterTableView.items = self.viewModel.kittens ?? []
		litterTableView.reloadData()
        self.rescueDateTextField.isEnabled = self.viewModel.isTextFieldEnable
        self.saveButton.isHidden = self.viewModel.saveBtnHidden
        self.editButton.isHidden = self.viewModel.editBtnHidden
        self.archiveButton.isHidden = self.viewModel.archiveBtnHidden
        self.favoriteButton.isHidden = self.viewModel.favoriteBtnHidden
        self.addKittenButton.isHidden = self.viewModel.addKittenBtnHidden
        self.rescueDateTextField.text = self.viewModel.rescueDate
//        litterTable.reloadData()
	}

	func setupTableViewUI() {
		self.view.addSubview(litterTableView)
		litterTableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			litterTableView.topAnchor.constraint(equalTo: self.topView.bottomAnchor, constant: 24),
			litterTableView.bottomAnchor.constraint(equalTo: self.addKittenButton.topAnchor, constant: -48),
			litterTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			litterTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor )
		])
	}
	
	func didSelect(item: Kitten, at indexPath: IndexPath) {
		
		let vc = KittenCardViewController.fromStoryboard { vc in
			vc.litterId = self.viewModel.id
	//        vc.kittenId = kittenId
			vc.litter = self.viewModel.litter
			vc.kitten = item
		}
		navigationController?.pushViewController(vc, animated: true)
	}
	
	
	// MARK: - Actions
    @IBAction private func makeItFavorite() {
        guard let litterId = litterId else { return }
        self.interactor.makeFavorite(litterId: litterId)
    }
    
    @IBAction private func addKitten() {
        
		let vc = KittenCardModalViewController.fromStoryboard { vc in
			vc.litter = self.viewModel.litter
			vc.isCreatingMode = true
			vc.isEditingMode = false
		}
        navigationController?.present(vc, animated: true)
    }
    @IBAction private func archiveLitter() {
        self.interactor.archiveLitter(litterId: self.viewModel.id)
    }
    
    @IBAction private func editLitter() {
        self.interactor.diplayMode(isEditing: true,
                                   isCreating: false,
                                   isDisplaying: false,
                                   litterId: litterId)
    }
    

    @IBAction private func save() {
        self.interactor.saveLitter(user: self.user,
								   rescueDate: rescueDateTextField.text?.toDate(format: self.viewModel.dateFormat),
								   isEditing: self.viewModel.isEditing,
								   litterId: self.viewModel.id)
//        self.interactor.refresh(litterId: self.viewModel.id,
//                                rescueDate: rescueDateTextField.text?.toDate(format: "dd/MM/yyyy"),
//                                isCreating: self.viewModel.isCreatingNew,
//                                user: self.user)
    }
}

//extension LitterViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        min(tableView.frame.height / 1.5, 50)
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let kittens = self.viewModel.kittens else {
//            return 0
//        }
//       return kittens.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "litterCell", for: indexPath)
//
//        cell.textLabel?.text = self.viewModel.kittens?[indexPath.row].firstName
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let kittenId = self.viewModel.kittens?[indexPath.row].id else {
//            return
//        }
//		let vc = KittenCardViewController.fromStoryboard { vc in
//			vc.litterId = self.viewModel.id
//	//        vc.kittenId = kittenId
//			vc.litter = self.viewModel.litter
//			vc.kitten = self.viewModel.kittens?[indexPath.row]
//		}
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}

extension LitterViewController: StoryboardProtocol {
    static var storyboardName: String {
        "Litter"
    }
    
    static var identifier: String? {
        "LitterViewController"
    }
}
