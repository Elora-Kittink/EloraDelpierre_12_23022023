//  HomeViewController.swift
//
//  Created by Elora on 27/02/2023.
//

import UtilsKit
import UIKit
import FirebaseCore
import FirebaseAuth

class HomeViewController: BaseViewController< HomeViewModel, HomePresenter, HomeInteractor> {
    
	// MARK: - Outlets

    @IBOutlet private weak var logOutbutton: UIButton!

    @IBOutlet private weak var welcomeLabel: UILabel!
	
	@IBOutlet weak var adminTile: UIView!
	@IBOutlet weak var littersTiles: UIView!
	@IBOutlet weak var advicesTiles: UIView!
	@IBOutlet weak var galerieTile: UIView!
	@IBOutlet weak var calendarTile: UIView!
	// MARK: - View life cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.adminTile.layer.cornerRadius = 12
		self.advicesTiles.layer.cornerRadius = 12
		self.littersTiles.layer.cornerRadius = 12
		self.galerieTile.layer.cornerRadius = 12
		self.calendarTile.layer.cornerRadius = 12
		
		self.interactor.userIsConnected()
		NotificationCenter.default.addObserver(forName: NSNotification.Name("userLogged"),
											   object: nil,
											   queue: nil) { [interactor] _ in
			self.interactor.userIsConnected()
		}
	}
//	TODO: quand LoginInteractor ou SignUpInteractor close() ça revient sur HomeViewCo,troller mais ça ne refresh pas donc on reste à l'état vide, il faudrait repasser dans le viewdidload
//	essayer de passer une nottification dans la completion du close() 
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
        self.welcomeLabel.text = "Bienvenu \(self.viewModel.user?.name ?? "")"
	}

	// MARK: - Actions
    
	@IBAction func didTapLittersTile(_ sender: UITapGestureRecognizer) {
		let vc = LitterHistoryViewController.fromStoryboard { vc in
			vc.user = self.viewModel.user
		}
		navigationController?.pushViewController(vc, animated: true)
	}
	
	@IBAction func didTapAdvicesTile(_ sender: Any) {
		let vc = AdvicesViewController.fromStoryboard()
		navigationController?.pushViewController(vc, animated: true)
	}

    @IBAction private func logOut() {
        self.interactor.logOut()
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
