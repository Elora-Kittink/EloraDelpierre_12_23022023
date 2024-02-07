//  SignUpViewController.swift
//
//  Created by Elora on 30/03/2023.
//
//
import UtilsKit
import UIKit
import FirebaseCore
import FirebaseAuth

/// `SignUpViewController` manages the user interface for user sign-up.
/// This controller inherits from `BaseViewController` and is specialized with `SignUpViewModel`, 
/// `SignUpPresenter`, and `SignUpInteractor` for its operation.
class SignUpViewController: BaseViewController
<
    SignUpViewModel,
    SignUpPresenter,
    SignUpInteractor
> {
    
    // MARK: - Outlets
    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet private weak var nameTF: UITextField!
    @IBOutlet private weak var passwordTF: UITextField!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.hideKeyboardOnTap()
		self.navigationItem.hidesBackButton = true
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
    
	/// Action for the sign-up button.
    @IBAction private func signUpAction() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name": "signup"])
		
           self.interactor.signUp(mail: emailTF.text ?? "",
                                   name: nameTF.text ?? "",
                                   password: passwordTF.text ?? "")
    }
    
	/// Action for the log-in button, redirects to the login page.
    @IBAction private func logInAction() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name": "login"])
		
//        rediriger vers la page login
		self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Storyboard Protocol

extension SignUpViewController: StoryboardProtocol {
    static var storyboardName: String {
        "SignUp"
    }
    
    static var identifier: String? {
        "SignUpViewController"
    }
}
