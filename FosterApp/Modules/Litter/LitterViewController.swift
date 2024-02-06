//  LitterViewController.swift
//
//  Created by Elora on 24/02/2023.
//

import UIKit
import UtilsKit

/// `LitterViewController` is a view controller that manages the display and interaction with a specific litter.
/// This controller inherits from `BaseViewController` and is specialized with `LitterViewModel`, 
/// `LitterPresenter`, and `LitterInteractor` for its operation.
class LitterViewController: BaseViewController<LitterViewModel, LitterPresenter, LitterInteractor> {
	
	// MARK: - Outlets
	
    @IBOutlet private weak var addKittenButton: UIButton!
    @IBOutlet private weak var rescueDateTextField: DatePickerField!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var editButton: UIButton!
    @IBOutlet private weak var archiveButton: UIButton!
    @IBOutlet private weak var favoriteButton: UIButton!
	@IBOutlet private weak var topView: UIView!
	
    // MARK: - Variables
    
	/// The identifier of the litter being displayed or edited.
    var litterId: String? {
        didSet {
            self.interactor.refresh(litterId: litterId)
        }
    }
	/// Indicates if the view controller is in create mode.
    var isCreateMode = false
	/// Indicates if the view controller is in display mode.
    var isDisplayMode = true
	/// Indicates if the view controller is in edit mode.
    var isEditMode = false
    var user: User!
	
	/// A table view for displaying kittens in the litter.
	lazy var  litterTableView: BaseTableView<KittenCell, Kitten> = {
	let litterTableView = BaseTableView <KittenCell, Kitten>(didSelect: didSelect(item: at: ))
	return litterTableView
	}()
	
	/// A view displayed when there are no kittens in the litter.
    let emptyView: UIView = {
        let view = UIView()
        
        let label = UILabel()
        label.text = "Cette portée n'a pas encore de chaton !"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
		label.adjustsFontForContentSizeCategory = true
		label.font = UIFont.preferredFont(forTextStyle: .body)
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()
	
	// MARK: - View life cycle
    
	/// Called after the controller's view is loaded into memory.
	override func viewDidLoad() {
		super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("newKittenCreated"),
                                               object: nil,
                                               queue: nil) { [interactor] _ in
            interactor.refresh(litterId: self.litterId)
        }
		self.setupTableViewUI()
        self.interactor.diplayMode(isEditing: isEditMode,
                                   isCreating: isCreateMode,
                                   isDisplaying: isDisplayMode,
                                   litterId: litterId)
        self.title = self.viewModel.title
		
		self.rescueDateTextField.accessibilityLabel = "date de sauvetage de la portée"
	}
	
	/// Called when the view has appeared on the screen.
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		AnalyticsManager.shared.log(event: .pageOpen, with: ["page": "\(Self.self)"])
	}
	
	// MARK: - Refresh
	
	/// Refreshes the UI with new data stored in the ViewModel.
	override func refreshUI() {
		super.refreshUI()
		// Update UI elements based on the ViewModel's state.

        self.isEditMode = self.viewModel.isEditing
        self.isCreateMode = self.viewModel.isCreatingNew
        self.isDisplayMode = self.viewModel.isDisplaying
        
		litterTableView.items = self.viewModel.kittens ?? []
		litterTableView.reloadData()
        self.rescueDateTextField.isEnabled = self.viewModel.isTextFieldEnable
        self.saveButton.isHidden = self.viewModel.saveBtnHidden
        self.editButton.isHidden = self.viewModel.editBtnHidden
        self.archiveButton.isHidden = self.viewModel.archiveBtnHidden
        self.favoriteButton.isHidden = self.viewModel.favoriteBtnHidden
        self.addKittenButton.isHidden = self.viewModel.addKittenBtnHidden
        self.rescueDateTextField.text = self.viewModel.rescueDate
        
        self.litterTableView.backgroundView = self.viewModel.kittens?.isEmpty ?? true ? self.emptyView : nil
        
        self.litterTableView.isUserInteractionEnabled = self.isEditMode ? false : true
//        litterTable.reloadData()
	}

	/// Sets up the UI elements of the table view.
	func setupTableViewUI() {
		// Implementation of table view UI setup.
		self.view.addSubview(litterTableView)
		litterTableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			litterTableView.topAnchor.constraint(equalTo: self.topView.bottomAnchor, constant: 24),
			litterTableView.bottomAnchor.constraint(equalTo: self.addKittenButton.topAnchor, constant: -48),
			litterTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			litterTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor )
		])
	}
	
	/// Handles the selection of a kitten item.
	/// - Parameters:
	///   - item: The `Kitten` item selected.
	///   - indexPath: The index path of the selected item in the table view.
	func didSelect(item: Kitten, at indexPath: IndexPath) {
		AnalyticsManager.shared.log(event: .tableViewCellPressed, with: ["cell_name": "\(item.firstName ?? "")"])
		
		let vc = KittenCardViewController.fromStoryboard { vc in
			vc.litterId = self.viewModel.id
	//        vc.kittenId = kittenId
			vc.litter = self.viewModel.litter
			vc.kitten = item
		}
		navigationController?.pushViewController(vc, animated: true)
	}
	
	
	// MARK: - Actions

	/// Action for marking the litter as favorite.
	@IBAction private func makeItFavorite() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name": "favorite_litter"])
		
        guard let litterId = litterId else { return }
        self.interactor.makeFavorite(litterId: litterId)
    }
    
	/// Action for adding a new kitten.
    @IBAction private func addKitten() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name": "add_kitten"])
		
		let vc = KittenCardModalViewController.fromStoryboard { vc in
			vc.litter = self.viewModel.litter
			vc.isCreatingMode = true
			vc.isEditingMode = false
		}
        navigationController?.present(vc, animated: true)
    }
	
	/// Action for archiving the litter.
    @IBAction private func archiveLitter() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name": "archive_kitten"])
		
        self.interactor.archiveLitter(litterId: self.viewModel.id)
    }
    
	/// Action for editing the litter.
    @IBAction private func editLitter() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name": "edit_litter"])
		
        self.interactor.diplayMode(isEditing: true,
                                   isCreating: false,
                                   isDisplaying: false,
                                   litterId: litterId)
    }

	/// Action for saving the litter.
    @IBAction private func save() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name": "save_litter"])
		
        self.interactor.saveLitter(user: self.user,
								   rescueDate: rescueDateTextField.text?.toDate(format: self.viewModel.dateFormat),
								   isEditing: self.viewModel.isEditing,
								   litterId: self.viewModel.id)
    }
}

// MARK: - Storyboard Protocol Conformance

extension LitterViewController: StoryboardProtocol {
    static var storyboardName: String {
        "Litter"
    }
    
    static var identifier: String? {
        "LitterViewController"
    }
}
