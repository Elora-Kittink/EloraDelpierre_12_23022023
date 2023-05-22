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
        self.viewModel.sections?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = self.viewModel.sections?.sections[section]
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
           view.backgroundColor =  UIColor(named: "beige")
             
           let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
           lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.text = section?.sectionTitle
           view.addSubview(lbl)
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

        let cell = tableView.dequeueReusableCell(withIdentifier: "adviceCell", for: indexPath)
        cell.textLabel?.text = advice.title

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let advice = self.viewModel.sections?.sections[safe: indexPath.section]?.advices[safe: indexPath.row] else {
            return
        }
                
        let vc = AdviceViewController.fromStoryboard()
                vc.html = advice.advice
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
