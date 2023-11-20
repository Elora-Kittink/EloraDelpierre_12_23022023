//  AdvicesViewController.swift
//
//  Created by Elora on 04/05/2023.
//

import UIKit
import UtilsKit

class AdvicesViewController: BaseViewController< AdvicesViewModel, AdvicesPresenter, AdvicesInteractor> {
	
	// MARK: - Outlets
	
	@IBOutlet weak var header: UIView!
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: - View life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.register(AdviceCell.self)
		self.interactor.refresh(url: self.viewModel.advicesUrl)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		AnalyticsManager.shared.log(event: .pageOpen,with: ["page": "\(Self.self)"])
	}
	
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
		tableView.reloadData()
	}
}

extension AdvicesViewController: UITableViewDataSource, UITableViewDelegate {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		self.viewModel.sections?.sections.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		80
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let section = self.viewModel.sections?.sections[section]
		let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
		
		let label = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
		label.font = UIFont.systemFont(ofSize: 28)
		label.text = section?.sectionTitle
		label.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(label)
		
		NSLayoutConstraint.activate([
			label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			label.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
			label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24)
		])
		
		return view
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let rows = self.viewModel.sections?.sections[section].advices.count else {
			return 0
		}
		
		return rows
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let advice = self.viewModel.sections?.sections[safe: indexPath.section]?.advices[safe: indexPath.row] else {
			return UITableViewCell()
		}
		
		let adviceCell: AdviceCell = tableView.dequeueCell(forIndexPath: indexPath)
		
		adviceCell.text = advice.title
		
		
		//        let cell = tableView.dequeueReusableCell(withIdentifier: "adviceCell", for: indexPath)
		//        cell.textLabel?.text = advice.title
		
		return adviceCell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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

extension AdvicesViewController: StoryboardProtocol {
	static var storyboardName: String {
		"Advices"
	}
	static var identifier: String? {
		"AdvicesViewController"
	}
}
