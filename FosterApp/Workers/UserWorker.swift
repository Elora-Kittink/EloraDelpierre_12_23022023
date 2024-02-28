//
//  LoginWorker.swift
//  FosterApp
//
//  Created by Elora on 06/06/2023.
//

import Foundation
import FirebaseAuth
import CoreDataUtilsKit

/// Protocol defining authentication functionalities.
protocol UserWorkerProtocol {
	func login(email: String, password: String) async throws -> User
	func signUp(mail: String, password: String) async throws -> User
	func userConnected() async throws -> User?
	func logOut()
	func deleteAccount()
	func storeUserInUserDefaults(user: User)
	func retrieveUser() -> User?
}

/// Custom error indicating that a user was not found.
struct UserNotFoundError: Error { }

/// `UserWorker` is responsible for managing Firebase user authentication.
/// It conforms to `UserWorkerProtocol` and provides functionality for user login, signup, and status checks.
struct UserWorker: UserWorkerProtocol {
	
	/// Authenticates a known user with email and password.
	/// - Parameters:
	///   - email: The email address of the user.
	///   - password: The password of the user.
	/// - Returns: A `User` object upon successful authentication.
	/// - Throws: An error if authentication fails.
	func login(email: String, password: String) async throws -> User {
		try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<User, Error>) in
			Auth.auth().signIn(withEmail: email,
							   password: password) { authResult, error in
				if let error {
					print("👹 Firebase fail login user \(email)")
					continuation.resume(throwing: error)
				} else if let user = authResult?.user {
					print("💃🏼 Firebase succeed login \(user.displayName ?? "no name") \(user.uid) user")
					continuation.resume(returning: User(from: user))
				} else {
					continuation.resume(throwing: UserNotFoundError())
				}
			}
		}
	}
	
	/// Registers a new user in Firebase with an email and password.
	/// - Parameters:
	///   - mail: The email address for the new user.
	///   - password: The password for the new user.
	/// - Returns: A `User` object upon successful registration.
	/// - Throws: An error if registration fails.
	func signUp(mail: String, password: String)  async throws -> User {

		try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<User, Error>) in
			Auth.auth().createUser(withEmail: mail,
							   password: password) { authResult, error in
				if let error {
					print("👹 Firebase fail create user at signup")
					continuation.resume(throwing: error)
				} else if let user = authResult?.user {
					print("💃🏼 Firebase succeed create \(user.displayName ?? "no name") \(user.uid) user")
					continuation.resume(returning: User(from: user))
				} else {
					print("👹 Firebase fail create user at signup")
					continuation.resume(throwing: UserNotFoundError())
				}
			}
		}
	}
	
	/// Checks if a user is currently connected.
	/// - Returns: A `User` object if a user is connected, otherwise `nil`.
	func userConnected() -> User? {
		guard let currentUser = Auth.auth().currentUser else {
			print("👹 No current user connected")
			return nil
		}
		print("💃🏼 Firebase success find current user")
		return User(from: currentUser)
	}
	
	/// Logs out the current user.
	func logOut() {
		do {
			try Auth.auth().signOut()
			NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userLogged"), object: nil)
			print("💃🏼 Firebase success signOut current user")
		} catch let error {
			// handle error here
			print("👹 Firebase fail signout current user")
			print("Error trying to sign out of Firebase: \(error.localizedDescription)")
		}
	}
	
	func deleteAccount() {
		Auth.auth().currentUser?.delete { error in
			if error != nil {
				print("👹 Firebase fail delete current user account")
			} else {
				print("💃🏼 Firebase success delete current user account")
				try? CoreDataManager.default.dropDatabase()
				self.logOut()
			}
		}
	}
	
	func storeUserInUserDefaults(user: User) {
		let encoder = JSONEncoder()
		if let encodedUser = try? encoder.encode(user) {
			UserDefaults.standard.set(encodedUser, forKey: "currentUser")
		}
	}
	
	func retrieveUser() -> User? {
		if let userData = UserDefaults.standard.data(forKey: "currentUser") {
			let decoder = JSONDecoder()
			do {
				let user = try decoder.decode(User.self, from: userData)
				return user
			} catch {
				print("Erreur lors du décodage de l'utilisateur : \(error)")
			}
		}
		return nil
	}
}
