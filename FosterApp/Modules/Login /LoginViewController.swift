//  LoginViewController.swift
//
//  Created by Elora on 29/03/2023.
//

import UtilsKit
import UIKit
import FirebaseCore
import FirebaseAuth

class LoginViewController: BaseViewController<LoginViewModel,
                           LoginPresenter,
                           LoginInteractor> {
    
    // MARK: - Outlets
    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet private weak var passwordTF: UITextField!
    // MARK: - Variables
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		self.isModalInPresentation = true
    }
    
    // MARK: - Refresh
    override func refreshUI() {
		if self.viewModel.needToClose {
			self.dismiss(animated: true) {
				NotificationCenter.default.post(name: NSNotification.Name("userLogged"), object: nil)
			}
		}
    }
    
    // MARK: - Actions
    
    @IBAction private func signUpAction() {
// renvoyer vers la page d'inscription
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
            let signupViewController = storyboard.instantiateViewController(identifier: "SignUpViewController")
        navigationController?.pushViewController(signupViewController, animated: true)
    }
    
    @IBAction private func logInAction() {
		let email = emailTF.text
		let password = passwordTF.text
        
		self.interactor.logIn(email: email, password: password)
    }
}


extension LoginViewController: StoryboardProtocol {
    static var storyboardName: String {
        "TabBar"
    }
    
    static var identifier: String? {
        "LoginViewController"
    }
}
