//  LoginInteractor.swift
//
//  Created by Elora on 29/03/2023.
//
import Foundation
import UIKit
import FirebaseAuth

/// `LoginInteractor` handles the business logic for the login process.
class LoginInteractor: Interactor
<
	LoginViewModel,
	LoginPresenter
> {
	
	var userWorker: UserWorkerProtocol = UserWorker()
	
	/// Initiates the login process with the provided credentials.
	/// - Parameters:
	///   - email: Email address for the account.
	///   - password: Password for the account.
	func logIn(email: String?, password: String?) {
		guard let email,
			  let password
		else {
			print("Les champs ne sont pas remplis")
			self.presenter.display(loader: false)
			return
		}
		
		self.presenter.display(loader: true)
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
