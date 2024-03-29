//
//  LoginTests.swift
//  FosterAppTests
//
//  Created by Elora on 06/06/2023.
//
import XCTest
import CoreDataUtilsKit
@testable import FosterApp

final class LoginTests: XCTestCase {

	struct MockUserWorker: UserWorkerProtocol {
		func storeUserInUserDefaults(user: FosterApp.User) { }
		
		func retrieveUser() -> FosterApp.User? {
			FosterApp.User(mail: "", id: "", name: "")
		}
		
		func logOut() { }
		
		func deleteAccount() { }
		
		func userConnected() async throws -> FosterApp.User? {
			FosterApp.User(mail: "", id: "", name: "")
		}
		
		func signUp(mail: String, password: String) async throws -> FosterApp.User {
			FosterApp.User(mail: "", id: "", name: "")
		}
		
		func login(email: String, password: String) async throws -> FosterApp.User {
			User(mail: "TEST", id: "ID", name: "TEST")
		}
	}
	
	func testSuccessLogUser() async throws {
		
		let test = await BaseTest<LoginViewModel, LoginPresenter, LoginInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.userWorker = MockUserWorker()
				interactor.logIn(email: "", password: "")
			}
		}
		
		DispatchQueue.main.async {
			XCTAssertEqual(test.viewModel.userID, "ID")
			XCTAssertEqual(test.viewModel.userMail, "TEST")
		}
	}
	
	func testFailLogUser() async throws {
		
		let test = await BaseTest<LoginViewModel, LoginPresenter, LoginInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.userWorker = MockUserWorker()
				interactor.logIn(email: nil, password: nil)
			}
		}
		
		DispatchQueue.main.async {
			XCTAssertEqual(test.viewModel.userID, "")
			XCTAssertEqual(test.viewModel.userMail, "")
		}
	}
}
