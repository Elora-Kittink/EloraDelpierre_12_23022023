//  SignUpInteractor.swift
//
//  Created by Elora on 30/03/2023.
//
import FirebaseCore
import FirebaseAuth

class SignUpInteractor: Interactor
<
    SignUpViewModel,
    SignUpPresenter
> {
    let worker = Worker()
   private var userId = ""
    
    func signUp(mail: String?, name: String?, password: String?) -> User? {
        guard let mail, let password, let name else {
            print("Les champs ne sont pas remplis")
            return nil
        }
        
        Auth.auth().createUser(withEmail: mail,
                               password: password) { (authResult, error) in
            if error != nil {
                print(error.debugDescription)
            } else {
                self.userId = Auth.auth().currentUser?.uid ?? ""
            }
        }
        guard let newUser = worker.createUser(name: name, mail: mail, id: userId) else { return nil }
        
        return newUser
    }
    
//    func createUser(name: String?, mail: String?, id: String?) -> User? {
//        guard let name, let mail, let id else {return nil}
//        guard let newUser = worker.createUser(name: name, mail: mail, id: id) else { return nil }
//
//        return newUser
//    }
}
