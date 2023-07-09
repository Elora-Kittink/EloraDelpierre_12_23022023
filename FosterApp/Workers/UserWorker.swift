//
//  LoginWorker.swift
//  FosterApp
//
//  Created by Elora on 06/06/2023.
//

import Foundation
import FirebaseAuth

struct UserWorker: UserWorkerProtocol {
	
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
	
	func userConnected() -> User? {
		
		guard let currentUser = Auth.auth().currentUser else {
			return nil
		}
		return User(from: currentUser)
	}
	
	func logOut() {
		
	}
}

struct UserNotFoundError: Error { }

protocol UserWorkerProtocol {
	func login(email: String, password: String) async throws -> User
	func signUp(mail: String, password: String) async throws -> User
	func userConnected() async throws -> User?
}
