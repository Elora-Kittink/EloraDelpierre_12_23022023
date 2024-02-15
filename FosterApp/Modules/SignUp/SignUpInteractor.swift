//  SignUpInteractor.swift
//
//  Created by Elora on 30/03/2023.
//
import FirebaseCore
import FirebaseAuth

/// `SignUpInteractor` handles the business logic for the `SignUpViewController`.
class SignUpInteractor: Interactor
<
	SignUpViewModel,
	SignUpPresenter
> {
	let worker = DBWorker()
	var userWorker: UserWorkerProtocol = UserWorker()
	
	/// Initiates the sign-up process with the provided credentials.
	/// - Parameters:
	///   - mail: Email address for the new account.
	///   - name: Name of the user.
	///   - password: Password for the new account.
	func signUp(mail: String?, name: String?, password: String?) {
		guard let mail,
			  let password,
			  let name else {
			print("Les champs ne sont pas remplis")
			self.presenter.display(loader: false)
			return
		}
		
		self.presenter.display(loader: true)
		
		Task {
			do {
				let user = try await self.userWorker.signUp(mail: mail, password: password)
				self.userWorker.storeUserInUserDefaults(user: User(mail: user.mail, id: user.id, name: name))
				let userlog = try await self.userWorker.login(email: user.mail, password: password)
			} catch {
				print(error)
			}
			self.presenter.display(loader: false)
			self.presenter.close()
		}
	}
}
