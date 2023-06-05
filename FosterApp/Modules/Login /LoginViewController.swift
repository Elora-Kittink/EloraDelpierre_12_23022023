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
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    // MARK: - Variables
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		self.isModalInPresentation = true
    }
    
    // MARK: - Refresh
    override func refreshUI() {
        super.refreshUI()
    }
    
    // MARK: - Actions
    
    @IBAction private func signUpAction() {
// renvoyer vers la page d'inscription
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
            let signupViewController = storyboard.instantiateViewController(identifier: "SignUpViewController")
        navigationController?.pushViewController(signupViewController, animated: true)
    }
    
    @IBAction func logInAction() {
//        gérer la connexion
        guard let email = emailTF.text, let password = passwordTF.text else {
            
            print("Les champs ne sont pas remplis")
            return
        }
        Auth.auth().signIn(withEmail: email,
                           password: password) { _, error in
            if error != nil {
                print(error.debugDescription)
            } else {
				self.dismiss(animated: true)
            }
        }
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
