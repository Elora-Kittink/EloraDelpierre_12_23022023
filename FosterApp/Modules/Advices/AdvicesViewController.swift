//  AdvicesViewController.swift
//
//  Created by Elora on 04/05/2023.
//

import UIKit
import UtilsKit


/// `AdvicesViewController` manages the user interface for displaying a list of advices.
/// It allows users to view and select various advices.
/// This controller inherits from `BaseViewController` and is specialized with `AdvicesViewModel`, `AdvicesPresenter`, and `AdvicesInteractor` for its operation.
class AdvicesViewController: BaseViewController< AdvicesViewModel, AdvicesPresenter, AdvicesInteractor> {
	
	// MARK: - Outlets
	
	@IBOutlet private weak var header: UIView!
	@IBOutlet private weak var tableView: UITableView!
	
	// MARK: - View life cycle
	/// Called after the controller's view is loaded into memory.
	/// Sets up the table view and initiates the data refresh process.
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.register(AdviceCell.self)
		self.interactor.refresh(url: self.viewModel.advicesUrl)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		AnalyticsManager.shared.log(event: .pageOpen, with: ["page": "\(Self.self)"])
	}
	
	// MARK: - Refresh
	/// Refreshes the user interface with the new data stored in the ViewModel.
	/// Reloads the table view to display the latest advices.
	override func refreshUI() {
		super.refreshUI()
		tableView.reloadData()
	}
}

// MARK: - UITableViewDataSource & Delegate

// extension of viewcontroller for tableview
extension AdvicesViewController: UITableViewDataSource, UITableViewDelegate {
	/// Returns the number of sections in the table view.
	/// - Parameter tableView: The table view requesting this information.
	/// - Returns: The number of sections
	func numberOfSections(in tableView: UITableView) -> Int {
		self.viewModel.sections?.sections.count ?? 0
	}

	/// Asks the data source for a cell to insert in a particular location of the table view.
	/// - Parameters:
	///   - tableView: The table view requesting the cell.
	///   - indexPath: The index path specifying the location of the cell.
	/// - Returns: A configured cell to display the advice.
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		80
	}
	
	/// Returns a view for the header of the specified section of the table view.
	/// - Parameters:
	///   - tableView: The table view requesting this information.
	///   - section: The section number requesting the header view.
	/// - Returns: A view to display as the header of the specified section.
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		// Implementation to create and return the header view
		let section = self.viewModel.sections?.sections[section]
		let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
		
		let label = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
		label.font = UIFont.systemFont(ofSize: 28)
		label.text = section?.sectionTitle
		label.translatesAutoresizingMaskIntoConstraints = false
		label.accessibilityTraits = .header
		
		view.addSubview(label)
		
		NSLayoutConstraint.activate([
			label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			label.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
			label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24)
		])
		
		return view
	}
	
	/// Returns the number of rows in a given section of the table view.
	/// - Parameters:
	///   - tableView: The table view requesting this information.
	///   - section: The section number requesting the number of rows.
	/// - Returns: The number of rows in the specified section.
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// Implementation to return the number of rows
		guard let rows = self.viewModel.sections?.sections[section].advices.count else {
			return 0
		}
		
		return rows
	}
	
	/// Asks the data source for a cell to insert at the specified index path of the table view.
	/// - Parameters:
	///   - tableView: The table view requesting the cell.
	///   - indexPath: The index path specifying the location of the cell.
	/// - Returns: A cell object to insert in the table view at the specified index path.
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// Implementation to create and return the cell
		guard let advice = self.viewModel.sections?.sections[safe: indexPath.section]?.advices[safe: indexPath.row] else {
			return UITableViewCell()
		}
		
		let adviceCell: AdviceCell = tableView.dequeueCell(forIndexPath: indexPath)
		
		adviceCell.text = advice.title
		adviceCell.accessibilityTraits = .button
		
		//        let cell = tableView.dequeueReusableCell(withIdentifier: "adviceCell", for: indexPath)
		//        cell.textLabel?.text = advice.title
		
		return adviceCell
	}
	
	/// Tells the delegate that a specified row is selected.
	/// - Parameters:
	///   - tableView: The table view informing the delegate about the row selection.
	///   - indexPath: The index path of the selected row.
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// Implementation for handling row selection
		AnalyticsManager.shared.log(event: .tableViewCellPressed, with: ["cell_name":"\(self.viewModel.sections?.sections[safe: indexPath.section]?.advices[safe: indexPath.row]?.title)"])
		
		guard let advice = self.viewModel.sections?.sections[safe: indexPath.section]?.advices[safe: indexPath.row] else {
			return
		}
		
		let vc = AdviceViewController.fromStoryboard { vc in
			vc.html = advice.advice
		}
		navigationController?.pushViewController(vc, animated: true)
	}
}

// MARK: - Storyboard Protocol

// Storyboard Protocol from UtilsKit Pod
extension AdvicesViewController: StoryboardProtocol {
	static var storyboardName: String {
		"Advices"
	}
	static var identifier: String? {
		"AdvicesViewController"
	}
}
