//  HomeViewController.swift
//
//  Created by Elora on 27/02/2023.
//

import UtilsKit
import UIKit
import FirebaseCore
import FirebaseAuth

class HomeViewController: BaseViewController
<
	HomeViewModel,
	HomePresenter,
	HomeInteractor
> {
//    var user: User!
    
	// MARK: - Outlets
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var helloTF: UITextField!
    @IBOutlet private weak var logOutbutton: UIButton!
	// MARK: - Variables
	
	// MARK: - View life cycle
    
	override func viewDidLoad() {
		super.viewDidLoad()
        print(Auth.auth().currentUser?.email)
        self.interactor.userIsConnected()
//        self.interactor.refresh(isUserConnected: self.viewModel.isUserConnected)
	}
	
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
        self.helloTF.text = self.viewModel.user?.name
	}

	// MARK: - Actions
    @IBAction private func buttonAction() {

        let vc = LitterHistoryViewController.fromStoryboard()
        
        navigationController?.pushViewController(vc, animated: true)
        print("ça passe")
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
