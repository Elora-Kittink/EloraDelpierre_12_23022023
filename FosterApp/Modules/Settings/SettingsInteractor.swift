//  SettingsInteractor.swift
//
//  Created by Elora on 06/11/2023.
//
import FirebaseAuth

class SettingsInteractor: Interactor
<
	SettingsViewModel,
	SettingsPresenter
> {
	let worker = DBWorker()
	var userWorker: UserWorkerProtocol = UserWorker()
	
	
	func refresh() {
		
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
				
//				get all kittens & all weighings
				
				let allLitters = worker.fetchAllLitters(userId: userFetched.id)
				   
				   let allKittens = allLitters.compactMap { litter in
					   worker.fetchAllKittensLitter(litterId: litter.id ?? "")
				   }
					   .flatMap { $0 }
				   
				   let allWeighings = allKittens.compactMap { kitten in
					   worker.fetchWeighingFromKittenId(kittenId: kitten.id ?? "")
				   }
					   .flatMap { $0 }
				
				
				self.presenter.display(kittens: allKittens, weighings: allWeighings, user: userFetched)
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
