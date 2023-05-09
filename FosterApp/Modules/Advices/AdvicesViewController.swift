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
    // MARK: - Variables
	
	// MARK: - View life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
        self.interactor.loadAdvices()
        self.tableView.delegate = self
        self.tableView.dataSource = self
	}
	
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
        tableView.reloadData()
	}

	// MARK: - Actions
}

extension AdvicesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.advices?.getSections().count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.viewModel.advices?.getSections()[section] else { return 0 }
        return self.viewModel.advices?.getAdvices(forSection: section).count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = self.viewModel.advices?.getSections()[indexPath.section] else { return UITableViewCell() }
        let advice = self.viewModel.advices?.getAdvices(forSection: section)
        
//        faire la cell à partir de ces données
        let cell = tableView.dequeueReusableCell(withIdentifier: "adviceCell", for: indexPath)
        cell.textLabel?.text = section.title
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = self.viewModel.advices?.getSections()[indexPath.section] else { return }
        let advice = self.viewModel.advices?.getAdvices(forSection: section)[indexPath.row]
        let vc = AdviceViewController.fromStoryboard()
        vc.html = advice?.advice
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
