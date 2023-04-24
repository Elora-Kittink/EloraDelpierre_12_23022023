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
    
    
    @MainActor
    func signUp(mail: String?, name: String?, password: String?) async {
        guard let mail, let password, let name else {
            print("Les champs ne sont pas remplis")
            return
        }
        do {
            let result = try await Auth.auth().createUser(withEmail: mail,
                                                          password: password)
            self.userId = result.user.uid
            
            print("💃🏼 Firebase succeed create \(result.user.uid) user")
        } catch {
            print("👹 Firebase fail create user at signup")
            print("🤡 \(error.localizedDescription)")
        }
        guard let newUser = worker.createUser(name: name, mail: mail, id: userId) else {
            print("👹 Worker fail \(userId) user at signup")
            return
        }
        
        do {
            let result = try await Auth.auth().signIn(withEmail: mail, password: password)
            HomeViewController.fromStoryboard().push()
            print("💃🏼 Firebase succeed login \(result.user.uid) user")
        } catch {
            print("👹 Firebase fail login \(mail) user")
            print("🤡 \(error.localizedDescription)")
        }
    }
}
