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
	let worker = DBWorker()
	var userWorker: UserWorkerProtocol = UserWorker()
	
	func userIsConnected() {
		
		Task {
			do {
				guard let user = try await self.userWorker.userConnected() else {
					self.presenter.noUserConnected()
					self.presenter.display(loader: false)
					return
				}
				guard let userFetched = worker.fetchUser(id: user.id) else {
					self.presenter.noUserConnected()
					self.presenter.display(loader: false)
					return
				}
				print("🙋🏼‍♀️ User \(userFetched.name) \(userFetched.id) is connected")
				self.presenter.presentUserConnected(user: userFetched)
			} catch {
				print(error)
			}
			self.presenter.display(loader: false)
		}
	}
	
	func logOut() {
		do {
			try Auth.auth().signOut()
			self.presenter.noUserConnected()
			self.presenter.display(loader: false)
			print("User logged out")
		} catch let error {
			// handle error here
			print("Error trying to sign out of Firebase: \(error.localizedDescription)")
		}
	}
}
