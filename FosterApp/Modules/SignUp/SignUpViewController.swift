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
    }
    
    // MARK: - Refresh
    override func refreshUI() {
        super.refreshUI()
    }
    
    // MARK: - Actions
    
    @IBAction private func signUpAction() {
        guard let userCreated = self.interactor.signUp(mail: emailTF.text, name: nameTF.text, password: passwordTF.text) else {
//            TODO: message d'aletre utilisateur non créé
            return
        }
//        TODO: Faire de ce storyboard l'initial, changer dans AppDelegate car pour l'instant ça marche pas 
        let homeVC = HomeViewController.fromStoryboard()
        homeVC.user = userCreated
            navigationController?.pushViewController(homeVC, animated: true)
    }
    
    @IBAction private func logInAction() {
//        rediriger vers la page login
        let loginVC = LoginViewController.fromStoryboard()
        navigationController?.pushViewController(loginVC, animated: true)
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
