//  SettingsInteractor.swift
//
//  Created by Elora on 06/11/2023.
//
import FirebaseAuth

/// `SettingsInteractor` handles the business logic for the `SettingsViewController`.
/// It communicates with database and user workers to fetch and update user data.
class SettingsInteractor: Interactor
<
	SettingsViewModel,
	SettingsPresenter
> {
	/// Declaration of worker instances
	let worker = DBWorker()
	var userWorker: UserWorkerProtocol = UserWorker()
	
	/// Fetches the user data and refreshes the UI.
	func refresh() {
		// Implementation for refreshing user data
		Task {
			do {
//	get user connected
				guard let user = try await self.userWorker.userConnected() else {
					self.presenter.noUserConnected()
					self.presenter.display(loader: false)
					return
				}
				
//				get all kittens & all weighings
				
				guard let user = userWorker.retrieveUser() else { return }
				let allLitters = worker.fetchAllLitters(user: user)
				   
				   let allKittens = allLitters.compactMap { litter in
					   worker.fetchAllKittensLitter(litterId: litter.id ?? "")
				   }
					   .flatMap { $0 }
				   
				   let allWeighings = allKittens.compactMap { kitten in
					   worker.fetchWeighingFromKittenId(kittenId: kitten.id ?? "")
				   }
					   .flatMap { $0 }
				
//				send data to presenter
				self.presenter.display(kittens: allKittens, weighings: allWeighings, user: user)
			} catch {
				print(error)
			}
			self.presenter.display(loader: false)
		}
	}
	
	/// Signs out the current user and updates the UI accordingly.

	func logOut() {
		self.userWorker.logOut()
	}
	
	func deleteAccount() {
		self.userWorker.deleteAccount()
		self.presenter.close()
	}
}
