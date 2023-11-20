//  SignUpViewController.swift
//
//  Created by Elora on 30/03/2023.
//
//
import UtilsKit
import UIKit
import FirebaseCore
import FirebaseAuth

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
	
    // MARK: - Variables
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.hidesBackButton = true
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		AnalyticsManager.shared.log(event: .pageOpen,with: ["page": "\(Self.self)"])
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
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name":"signup"])
		
        Task {
          await self.interactor.signUp(mail: emailTF.text ?? "",
                                   name: nameTF.text ?? "",
                                   password: passwordTF.text ?? "")
        }
    }
    
    @IBAction private func logInAction() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name":"login"])
		
//        rediriger vers la page login
		self.navigationController?.popViewController(animated: true)
    }
}

extension SignUpViewController: StoryboardProtocol {
    static var storyboardName: String {
        "SignUp"
    }
    
    static var identifier: String? {
        "SignUpViewController"
    }
}
