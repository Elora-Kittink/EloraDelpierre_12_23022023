//  LoginInteractor.swift
//
//  Created by Elora on 29/03/2023.
//
import Foundation
import UIKit
import FirebaseAuth

class LoginInteractor: Interactor
<
	LoginViewModel,
	LoginPresenter
> {
	
	var userWorker: UserWorkerProtocol = UserWorker()
	
	func logIn(email: String?, password: String?) {
		guard let email,
			  let password
		else {
			print("Les champs ne sont pas remplis")
			self.presenter.display(loader: false)
			return
		}
		
		self.presenter.display(loader: true)
//		TODO: worker fail get DBUser, connexion impossible, on arrive pas sur la Home
		Task {
			do {
				let user = try await self.userWorker.login(email: email, password: password)
				self.presenter.display(user: user)
			} catch {
				print(error)
			}
			self.presenter.display(loader: false)
			self.presenter.close()
		}
	}
}
