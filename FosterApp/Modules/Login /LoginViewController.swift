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
