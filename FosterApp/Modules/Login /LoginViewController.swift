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
        
        
    }
    
    // MARK: - Refresh
    override func refreshUI() {
        super.refreshUI()
    }
    
    // MARK: - Actions
    
    @IBAction func signUpAction() {
// renvoyer vers la page d'inscription
        let signupVC = SignUpViewController.fromStoryboard()
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @IBAction func logInAction() {
//        gérer la connexion
        guard let email = emailTF.text, let password = passwordTF.text else {
            
            print("Les champs ne sont pas remplis")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) {(authResult, error) in
            if error != nil {
                print(error.debugDescription)
            } else {
                
            }
            
        }
    }
}


extension LoginViewController: StoryboardProtocol {
    static var storyboardName: String {
        "SignUp"
    }
    
    static var identifier: String? {
        "LoginViewController"
    }
}
