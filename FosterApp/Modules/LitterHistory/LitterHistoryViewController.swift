//  LitterHistoryViewController.swift
//
//  Created by Elora on 27/02/2023.
//
import UtilsKit
import UIKit

/// `LitterHistoryViewController`  Manages the litter history screen of the application.
/// This controller inherits from `BaseViewController` and is specialized with `LitterHistoryViewModel`, `LitterHistoryPresenter`,
///  and `LitterHistoryInteractor` for its operation.
class LitterHistoryViewController: BaseViewController<LitterHistoryViewModel,
	 LitterHistoryPresenter, LitterHistoryInteractor> {
	
	// MARK: - Outlets
    @IBOutlet private weak var headerLabel: UILabel!
	@IBOutlet private weak var addLitterButton: UIButton!
	
	// MARK: - Variables
	
	
	/// A table view to display litter history, initialized lazily.
	lazy var  littersTableView: BaseTableView<LitterCell, Litter> = {
		let littersTableView = BaseTableView <LitterCell, Litter>(didSelect: didSelect(item:at:))
	return littersTableView
	}() // homework, Why did we change it to lazy var and into a self executed closure?
    
	/// A view displayed when there are no litters.
	let emptyView: UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "Vous n'avez pas encore de portée !"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
		self.interactor.refresh()
		super.viewDidLoad()
		self.setupUI()
        self.title = self.viewModel.title
	}
	
	/// Called when the view has appeared on the screen.
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		AnalyticsManager.shared.log(event: .pageOpen, with: ["page": "\(Self.self)"])
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.interactor.refresh()
	}
    
	// MARK: - Refresh
	
	/// Refreshes the UI with new data stored in the ViewModel.
	override func refreshUI() {
		super.refreshUI()
		littersTableView.items = self.viewModel.litters ?? []
		littersTableView.reloadData()
        littersTableView.backgroundView = self.viewModel.litters?.isEmpty ?? true ? self.emptyView : nil
		littersTableView.accessibilityValue = "\(self.viewModel.litters?.count ?? 0) portée(s)"
	}
	
	/// Sets up the UI elements of the view controller.
	func setupUI() {
		self.view.addSubview(littersTableView)
		littersTableView.translatesAutoresizingMaskIntoConstraints = false
		littersTableView.accessibilityLabel = "Liste des portées"
		
		NSLayoutConstraint.activate([
			littersTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
			littersTableView.bottomAnchor.constraint(equalTo: self.addLitterButton.topAnchor, constant: -48),
			littersTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			littersTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor )
		])
	}

	// MARK: - Actions
	
	/// Handles the selection of a litter item.
	/// - Parameters:
	///   - item: The `Litter` item selected.
	///   - indexPath: The index path of the selected item in the table view.
	func didSelect(item: Litter, at indexPath: IndexPath) {
		AnalyticsManager.shared.log(event: .tableViewCellPressed, with: ["cell_name": "\(item.rescueDate ?? "")"])
		
		let vc = LitterViewController.fromStoryboard { vc in
			vc.litterId = item.id
			vc.isDisplayMode = true
			vc.isCreateMode = false
			vc.isEditMode = false
		}
		navigationController?.pushViewController(vc, animated: true)
	}
	
	/// Action for the add litter button.
	@IBAction private func addLitter() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name": "add_litter"])
		
		let vc = LitterViewController.fromStoryboard { vc in
			vc.isCreateMode = true
			vc.isDisplayMode = false
			vc.isEditMode = false
		}
		navigationController?.pushViewController(vc, animated: true)
	}
}

// MARK: - Storyboard Protocol Conformance

extension LitterHistoryViewController: StoryboardProtocol {
    static var storyboardName: String {
        "LitterHistory"
    }
    
    static var identifier: String? {
        "LitterHistoryViewController"
    }
}
