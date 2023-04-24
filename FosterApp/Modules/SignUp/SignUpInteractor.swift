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
    func signUp(mail: String?, name: String?, password: String?) async -> User? {
        guard let mail, let password, let name else {
            print("Les champs ne sont pas remplis")
            return nil
        }
        do {
           let result = try await Auth.auth().createUser(withEmail: mail,
                                       password: password)
            self.userId = result.user.uid
            print("😈 \(result.user.uid)")
            print("😈 \(self.userId)")

            print("New user Signin !")
        }
        catch {
            print("🤡 \(error.localizedDescription)" )
        }
//        Auth.auth().createUser(withEmail: mail,
//                               password: password) { authResult, error in
//            if error != nil {
//                print("🤡 \(error.debugDescription)" )
//            }
//            guard let authResult = authResult else { return }
//            let user = authResult.user
//            self.userId = user.uid
//
//            print(" 👹 \(authResult)")
//        }
        guard let newUser = worker.createUser(name: name, mail: mail, id: userId) else { return nil }
        print("👽 \(newUser.id)")
        return newUser
    }

    
        
//        return User(from: "", id: "", name: "")
//    }
    
    //    func createUser(name: String?, mail: String?, id: String?) -> User? {
    //        guard let name, let mail, let id else {return nil}
    //        guard let newUser = worker.createUser(name: name, mail: mail, id: id) else { return nil }
    //
    //        return newUser
    //    }
}
