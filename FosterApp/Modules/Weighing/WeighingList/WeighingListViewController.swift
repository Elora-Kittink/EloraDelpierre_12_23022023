//  WeighingListViewController.swift
//
//  Created by Elora on 09/07/2023.
//

import UIKit
import UtilsKit

/// `WeighingListViewController` manages the user interface for displaying a list of weighings.
/// It allows users to view, add, and edit weighings for a specific kitten.
/// This controller inherits from `BaseViewController` and is specialized with `WeighingListViewModel`, 
/// `WeighingListPresenter`, and `WeighingListInteractor` for its operation.
class WeighingListViewController: BaseViewController
<
	WeighingListViewModel,
	WeighingListPresenter,
	WeighingListInteractor
> {
	
	// MARK: - Outlets
	/// Button for adding new weighings.
	@IBOutlet private weak var addWeighingButton: UIButton!
	/// Container view for the weighings table.
	@IBOutlet private weak var contentView: UIView!

	// MARK: - Variables
	
	/// The kitten object for which weighings are being displayed.
	var kitten: Kitten!
	/// A custom generic table view for displaying weighing types.
	lazy var weighingsTableView: BaseTableView<WeighingCell, Weighing> = {
		let weighingsTableView = BaseTableView<WeighingCell, Weighing>(didSelect: didSelect(item: at:))
	return weighingsTableView
	}()

	// MARK: - View life cycle
	/// Called after the controller's view is loaded into memory.
	override func viewDidLoad() {
		self.interactor.refresh(kitten: self.kitten)
		super.viewDidLoad()
		self.setupTableViewUI()
        self.title = self.viewModel.title
	}
	
	/// Refreshes the weighings data when the view appears.
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		// Implementation for refreshing weighings data
		self.interactor.refresh(kitten: self.kitten)
	}
	
	/// Logs a page open event when the view appears.
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		// Log page open event
		AnalyticsManager.shared.log(event: .pageOpen, with: ["page": "\(Self.self)"])
	}
	
	// MARK: - Refresh
	
	/// Refreshes the user interface with the new data stored in the ViewModel.
	override func refreshUI() {
		super.refreshUI()
		// Implementation for refreshing UI
		weighingsTableView.items = self.viewModel.weights ?? []
		weighingsTableView.reloadData()
	}

	// MARK: - Actions
	
	/// Sets up constraints for the custom table view.
	func setupTableViewUI() {
		// Implementation for setting up table view UI
		self.view.addSubview(weighingsTableView)
		weighingsTableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			weighingsTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
			weighingsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			weighingsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			weighingsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor )
		])
	}
	
	/// Handles the selection of a weighing item from the table.
	/// - Parameters:
	///   - item: The `Weighing` object that was selected.
	///   - indexPath: The `IndexPath` of the selected item in the table view.
	func didSelect(item: Weighing, at indexPath: IndexPath) {
		AnalyticsManager.shared.log(event: .tableViewCellPressed, with: ["cell_name": "\(item.id ?? "")"])
		// Implementation for handling weighing item selection
		let vc = AddWeightViewController.fromStoryboard { vc in
			vc.kitten = self.kitten
			vc.isEditingMode = true
			vc.weighing = item
		}
		navigationController?.pushViewController(vc, animated: true)
	}
	
	/// Handles the action when the add weighing button is tapped.
	/// Presents the AddWeightViewController to allow adding a new weighing.
	@IBAction private func addWeighing() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name": "add_weighing"])
		// Implementation for handling add weighing action
		let vc = AddWeightViewController.fromStoryboard { vc in
			vc.kitten = self.kitten
			vc.isEditingMode = false
			vc.weighing = nil
		}
		navigationController?.pushViewController(vc, animated: true)
	}
}

// MARK: - StoryboardProtocol

/// Extension conforming to StoryboardProtocol for storyboard-based instantiation.
extension WeighingListViewController: StoryboardProtocol {
	static var storyboardName: String {
		"WeighingList"
	}
	
	static var identifier: String? {
		"WeighingListViewController"
	}
}
