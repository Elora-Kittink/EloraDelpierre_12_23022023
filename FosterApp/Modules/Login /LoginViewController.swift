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
                           password: password) { authResult, error in
            if error != nil {
                print(error.debugDescription)
            } else {
                HomeViewController.fromStoryboard().push()
//                let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
//                    let mainTabBarController = storyboard.instantiateViewController(identifier: "TabBarController")
//                    // This is to get the SceneDelegate object from your view controller
//                    // then call the change root view controller function to change to main tab bar
//                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
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
