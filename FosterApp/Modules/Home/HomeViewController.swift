//  HomeViewController.swift
//
//  Created by Elora on 27/02/2023.
//

import UIKit
import UtilsKit

class HomeViewController: BaseViewController
<
	HomeViewModel,
	HomePresenter,
	HomeInteractor
> {
    var user: User!
    
	// MARK: - Outlets
    @IBOutlet private weak var button: UIButton!
	// MARK: - Variables
	
	// MARK: - View life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
	}

	// MARK: - Actions
    @IBAction private func buttonAction() {
//        guard let recipeId = self.viewModel.recipesFullInfo[indexPath.row].id else {
//            return
//        }
        let vc = LitterHistoryViewController.fromStoryboard()
     
        navigationController?.pushViewController(vc, animated: true)
        print("ça passe")
    }
}

extension HomeViewController: StoryboardProtocol {
    static var storyboardName: String {
        "Home"
    }
    
    static var identifier: String? {
        "HomeViewController"
    }
}
