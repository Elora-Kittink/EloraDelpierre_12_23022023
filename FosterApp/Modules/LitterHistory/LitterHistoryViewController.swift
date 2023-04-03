//  LitterHistoryViewController.swift
//
//  Created by Elora on 27/02/2023.
//
import UtilsKit
import UIKit

class LitterHistoryViewController: BaseViewController<LitterHistoryViewModel,
	 LitterHistoryPresenter, LitterHistoryInteractor> {
    
    
	
	// MARK: - Outlets
    @IBOutlet private weak var litterHistoryTableView: UITableView!
    
	// MARK: - Variables
	
	// MARK: - View life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
        self.litterHistoryTableView.delegate = self
        self.litterHistoryTableView.dataSource = self
	}
	
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.interactor.refresh()
    }
    
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
        litterHistoryTableView.reloadData()
	}

	// MARK: - Actions
    @IBAction private func addLitter() {
        let vc = LitterViewController.fromStoryboard()
        vc.isCreateMode = true
        vc.isDisplayMode = false
        vc.isEditMode = false
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension LitterHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        min(tableView.frame.height / 1.5, 50)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let litters = self.viewModel.litters else {
            return 0
        }
       return litters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "litterCell", for: indexPath)
        
        cell.textLabel?.text = self.viewModel.litters?[indexPath.row].rescueDate
        return cell
        
//        guard let cell = litterHistoryTableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeCell
//            else { return UITableViewCell() }
////      donne la bonne recette pour remplir les outlets
////      le "=" notifie et active le didSet de outletFilling dans RecipeCell
//        guard let recipes = self.viewModel.recipes else {
//            return UITableViewCell()
//        }
//        cell.outletFilling = recipes[indexPath.row]
//        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let litterId = self.viewModel.litters?[indexPath.row].id else {
            return
        }
        let vc = LitterViewController.fromStoryboard()
        vc.litterId = litterId
        vc.isDisplayMode = true
        vc.isCreateMode = false
        vc.isEditMode = false
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LitterHistoryViewController: StoryboardProtocol {
    static var storyboardName: String {
        "LitterHistory"
    }
    
    static var identifier: String? {
        "LitterHistoryViewController"
    }
}
