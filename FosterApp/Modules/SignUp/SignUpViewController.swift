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
    
    // MARK: - Refresh
    override func refreshUI() {
        super.refreshUI()
    }
    
    // MARK: - Actions
    
    @IBAction private func signUpAction() {
        
        Task {
          await self.interactor.signUp(mail: emailTF.text ?? "",
                                   name: nameTF.text ?? "",
                                   password: passwordTF.text ?? "")
        }
    }
    
    @IBAction private func logInAction() {
//        rediriger vers la page login
		self.navigationController?.popViewController(animated: true)
    }
}

extension SignUpViewController: StoryboardProtocol {
    static var storyboardName: String {
        "TabBar"
    }
    
    static var identifier: String? {
        "SignUpViewController"
    }
}
