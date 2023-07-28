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
	

	// MARK: - Variables
	
	var kitten: Kitten!
	lazy var  weighingsTableView: BaseTableView<WeighingCell, Weighing> = {
	let weighingsTableView =  BaseTableView <WeighingCell, Weighing>(didSelect: didSelect(item: at: ))
	return weighingsTableView
	}()
	
	// MARK: - View life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setupTableViewUI()
	}
	
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
		self.weighingsTableView.items = self.viewModel.weights ?? []
		self.weighingsTableView.reloadData()
	}

	// MARK: - Actions
	
	func setupTableViewUI() {
		self.view.addSubview(weighingsTableView)
		weighingsTableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			weighingsTableView.topAnchor.constraint(equalTo: self.view.bottomAnchor),
			weighingsTableView.bottomAnchor.constraint(equalTo: self.view.topAnchor),
			weighingsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			weighingsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor )
		])
	}
	
	func didSelect(item: Weighing, at indexPath: IndexPath) {
		
		let vc = AddWeightViewController.fromStoryboard { vc in
			vc.kitten = self.kitten
			vc.isEditingMode = true
			vc.weighing = item
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
