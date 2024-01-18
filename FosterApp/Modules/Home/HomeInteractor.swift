//  HomeInteractor.swift
//
//  Created by Elora on 27/02/2023.
//

import FirebaseAuth

/// `HomeInteractor` handles the business logic for the `HomeViewController`.
class HomeInteractor: Interactor
<
	HomeViewModel,
	HomePresenter
> {
	let worker = DBWorker()
	var userWorker: UserWorkerProtocol = UserWorker()
	
	/// Checks if a user is currently connected and updates the UI accordingly.
	func userIsConnected() {
		// Implementation of user connection check.
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
	
	/// Logs out the current user.
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
	
	/// Handles the selection of a tile on the Home screen.
	func didSelectTile(tileType: Tiles, user: User) {
		// Implementation of tile selection handling.
		switch tileType {
			
		case .litters:
			LitterHistoryViewController.fromStoryboard {
				$0.user = user
			}
			.push()
			
		case .advices:
			AdvicesViewController.fromStoryboard().push()
			
		case .gallery, .admin, .calendar, .contacts, .medicalHistory, .weighingHistory:
			print("Pas encore implémenté")
//			TODO: faire une popup "pas encore implémenté"
		}
	}
}
