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
				self.presenter.presentUserConnected(user: user)
			} catch {
				print(error)
			}
			self.presenter.display(loader: false)
		}
	}
	
	/// Handles the selection of a tile on the Home screen.
	func didSelectTile(tileType: Tiles, user: User) {
		// Implementation of tile selection handling.
		switch tileType {
			
		case .litters:
			LitterHistoryViewController.fromStoryboard().push()
			
		case .advices:
			AdvicesViewController.fromStoryboard().push()
			
		case .gallery, .admin, .calendar, .contacts, .medicalHistory, .weighingHistory:
			print("Pas encore implémenté")
//			TODO: faire une popup "pas encore implémenté"
		}
	}
}
