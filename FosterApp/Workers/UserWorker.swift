//
//  LoginWorker.swift
//  FosterApp
//
//  Created by Elora on 06/06/2023.
//

import Foundation
import FirebaseAuth

/// Protocol defining authentication functionalities.
protocol UserWorkerProtocol {
	func login(email: String, password: String) async throws -> User
	func signUp(mail: String, password: String) async throws -> User
	func userConnected() async throws -> User?
	func logOut()
	func deleteAccount()
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
					continuation.resume(throwing: error)
				} else if let user = authResult?.user {
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
					print("💃🏼 Firebase succeed create \(user.uid) user")
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
			return nil
		}
		return User(from: currentUser)
	}
	
	/// Logs out the current user.
	/// - Note: This function needs to be completed with logout logic.
	 
//	TODO: faire tests unitaires
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
			}
		}
			self.logOut()
	}
}
