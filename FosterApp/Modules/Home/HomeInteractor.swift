//  HomeInteractor.swift
//
//  Created by Elora on 27/02/2023.
//

import FirebaseAuth
import UtilsKit

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
				guard let firebaseUser = try await self.userWorker.userConnected() 
				else {
					self.presenter.noUserConnected()
					self.presenter.display(loader: false)
					return
				}
				guard let user = userWorker.retrieveUser() else { return }
				self.presenter.presentUserConnected(user: user)
			} catch {
				print(error)
			}
			self.presenter.display(loader: false)
		}
	}
	
	/// Handles the selection of a tile on the Home screen.
	func didSelectTile(tileType: Tiles, user: User) {
		let continueAction = AlertAction(title: "Continuer", style: .default, completion: {})
		
		// Implementation of tile selection handling.
		switch tileType {
			
		case .litters:
			LitterHistoryViewController.fromStoryboard().push()
			
		case .advices:
			AdvicesViewController.fromStoryboard().push()
			
		case .gallery, .admin, .calendar, .contacts, .medicalHistory, .weighingHistory:
			AlertManager.shared.show(actions: [continueAction],
									 title: "WIP",
									 message: "Implémentation future",
									 alignment: .center,
									 preferredStyle: .alert,
									 sourceView: nil)
		}
	}
}
