//  WeighingListViewController.swift
//
//  Created by Elora on 09/07/2023.
//

import UIKit
import UtilsKit

class WeighingListViewController: BaseViewController
<
	WeighingListViewModel,
	WeighingListPresenter,
	WeighingListInteractor
> {
	
	// MARK: - Outlets
	@IBOutlet private weak var addWeighingButton: UIButton!
	@IBOutlet private weak var contentView: UIView!

	// MARK: - Variables
	
	var kitten: Kitten!
	
	lazy var weighingsTableView: BaseTableView<WeighingCell, Weighing> = {
		let weighingsTableView =  BaseTableView<WeighingCell, Weighing>(didSelect: didSelect(item: at:))
	return weighingsTableView
	}()

	// MARK: - View life cycle
	override func viewDidLoad() {
		self.interactor.refresh(kitten: self.kitten)
		super.viewDidLoad()
		self.setupTableViewUI()
        self.title = self.viewModel.title
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		self.interactor.refresh(kitten: self.kitten)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		AnalyticsManager.shared.log(event: .pageOpen, with: ["page": "\(Self.self)"])
	}
	
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
		weighingsTableView.items = self.viewModel.weights ?? []
		weighingsTableView.reloadData()
	}

	// MARK: - Actions
	
	func setupTableViewUI() {
		self.view.addSubview(weighingsTableView)
		weighingsTableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			weighingsTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
			weighingsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			weighingsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			weighingsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor )
		])
	}
	
	func didSelect(item: Weighing, at indexPath: IndexPath) {
		AnalyticsManager.shared.log(event: .tableViewCellPressed, with: ["cell_name": "\(item.id)"])
		
		let vc = AddWeightViewController.fromStoryboard { vc in
			vc.kitten = self.kitten
			vc.isEditingMode = true
			vc.weighing = item
		}
		navigationController?.pushViewController(vc, animated: true)
	}
	
	@IBAction private func addWeighing() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name": "add_weighing"])
		
		let vc = AddWeightViewController.fromStoryboard { vc in
			vc.kitten = self.kitten
			vc.isEditingMode = false
			vc.weighing = nil
		}
		navigationController?.pushViewController(vc, animated: true)
	}
}

extension WeighingListViewController: StoryboardProtocol {
	static var storyboardName: String {
		"WeighingList"
	}
	
	static var identifier: String? {
		"WeighingListViewController"
	}
}
