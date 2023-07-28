//  WeighingListViewController.swift
//
//  Created by Elora on 09/07/2023.
//

import UIKit

class WeighingListViewController: BaseViewController
<
	WeighingListViewModel,
	WeighingListPresenter,
	WeighingListInteractor
> {
	
	// MARK: - Outlets
	
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var addWeightButton: UIButton!

	// MARK: - Variables
	
	var kitten: Kitten!
	
	// MARK: - View life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.delegate = self
		self.tableView.dataSource = self
	}
	
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
		self.tableView.reloadData()
	}

	// MARK: - Actions
	
	@IBAction private func didTapAddWeight() {
		
	}
}

extension WeighingListViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		min(tableView.frame.height / 1.5, 50)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		guard let litters = self.viewModel.weighings else {
//			return 0
//		}
//	   return litters.count
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
//		let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
//		self.interactor.refreshCell(litter: self.viewModel.weights?[indexPath.row])
//		cell.textLabel?.text = self.viewModel.kittenList
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		guard let litterId = self.viewModel.litters?[indexPath.row].id else {
//			return
//		}
//		let vc = LitterViewController.fromStoryboard { vc in
//			vc.user = self.user
//			vc.litterId = litterId
//			vc.isDisplayMode = true
//			vc.isCreateMode = false
//			vc.isEditMode = false
//		}
//		navigationController?.pushViewController(vc, animated: true)
	}
}
