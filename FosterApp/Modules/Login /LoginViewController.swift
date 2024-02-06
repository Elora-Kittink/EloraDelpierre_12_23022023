//  LoginViewController.swift
//
//  Created by Elora on 29/03/2023.
//

import UtilsKit
import UIKit
import FirebaseCore
import FirebaseAuth

/// `LoginViewController` manages the user interface for user login.
/// This controller inherits from `BaseViewController` and is specialized with `LoginViewModel`, 
/// `LoginPresenter`, and `LoginInteractor` for its operation.
class LoginViewController: BaseViewController<LoginViewModel,
                           LoginPresenter,
                           LoginInteractor> {
    
    // MARK: - Outlets
    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet private weak var passwordTF: UITextField!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.hideKeyboardOnTap()
		self.isModalInPresentation = true
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		AnalyticsManager.shared.log(event: .pageOpen, with: ["page": "\(Self.self)"])
	}
    
    // MARK: - Refresh
	/// Refreshes the UI with new data stored in the ViewModel.
    override func refreshUI() {
		if self.viewModel.needToClose {
			self.dismiss(animated: true) {
				NotificationCenter.default.post(name: NSNotification.Name("userLogged"), object: nil)
			}
		}
    }
    
    // MARK: - Actions
	/// Action for the sign-up button, navigates to the sign-up page.
    @IBAction private func signUpAction() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name": "signup"])

        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
            let signupViewController = storyboard.instantiateViewController(identifier: "SignUpViewController")
        navigationController?.pushViewController(signupViewController, animated: true)
    }
    
	/// Action for the log-in button, initiates the login process.
    @IBAction private func logInAction() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name": "login"])
		
		let email = emailTF.text
		let password = passwordTF.text
        
		self.interactor.logIn(email: email, password: password)
    }
}

// MARK: - Storyboard Protocol
extension LoginViewController: StoryboardProtocol {
    static var storyboardName: String {
        "Login"
    }
    
    static var identifier: String? {
        "LoginViewController"
    }
}
