//  HomeInteractor.swift
//
//  Created by Elora on 27/02/2023.
//

import FirebaseAuth

class HomeInteractor: Interactor
<
	HomeViewModel,
	HomePresenter
> {
    let worker = Worker()
    
    func userIsConnected() {
        guard let userConnected = Auth.auth().currentUser else {
            self.presenter.noUserConnected()
            return
        }
        print("🙋🏼‍♀️ User \(userConnected.uid) is connected")
        guard let user = worker.fetchUser(id: userConnected.uid) else {
            return
        }
        self.presenter.presentUserConnected(user: user)
    }
    
//    func refresh(isUserConnected: Bool) {
//        if isUserConnected {
//            self.presenter.display()
//        } else {
//            self.presenter.displayLoginPage()
//        }
//    }
    
    func logOut() {
        do {
             try Auth.auth().signOut()
            LoginViewController.fromStoryboard().push()
            print("User logged out")
         } catch let error {
             // handle error here
             print("Error trying to sign out of Firebase: \(error.localizedDescription)")
         }
    }
}
