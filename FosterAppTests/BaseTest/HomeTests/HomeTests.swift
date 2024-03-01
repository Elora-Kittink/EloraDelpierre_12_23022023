//
//  HomeTests.swift
//  FosterAppTests
//
//  Created by Elora on 22/05/2023.
//

import XCTest
import CoreDataUtilsKit
@testable import FosterApp

final class HomeTests: XCTestCase {
	
	struct MockUserWorker: UserWorkerProtocol {
		
		func logOut() {
			print("logOut")
		}
		
		func deleteAccount() {
			print("deleteAccount")
		}
		
		func storeUserInUserDefaults(user: FosterApp.User) {
			print("storeUserInUserDefaults")
		}
		
		func retrieveUser() -> FosterApp.User? {
			FosterApp.User(mail: "TEST", id: "ID", name: "TEST")
		}
		
		func userConnected() async throws -> FosterApp.User? {
			FosterApp.User(mail: "TEST", id: "ID", name: "TEST")
		}
		
		func signUp(mail: String, password: String) async throws -> FosterApp.User {
			FosterApp.User(mail: "TEST", id: "ID", name: "TEST")
		}
		
		func login(email: String, password: String) async throws -> FosterApp.User {
			User(mail: "TEST", id: "ID", name: "TEST")
		}
	}
	
	
	let DBworker = DBWorker()
	let userWorker = MockUserWorker()
	var userLogged: User!
	
	override func setUpWithError() throws {
		try super.setUpWithError()
		try? CoreDataManager.default.dropDatabase()
		
		let expectation = XCTestExpectation(description: "Login")
		
		Task {
			do {
				let user = try await self.userWorker.login(email: "TEST", password: "TEST")
				self.userLogged = try XCTUnwrap(user)
				expectation.fulfill()
			} catch {
				XCTFail(error.localizedDescription)
			}
		}
		
		wait(for: [expectation], timeout: 10.0)
	}
	
	func testSuccesIsUserLogged() async throws {
		
		let test = await BaseTest<HomeViewModel, HomePresenter, HomeInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.userWorker = MockUserWorker()
				interactor.userIsConnected()
			}
		}
		
		DispatchQueue.main.async {
			XCTAssertEqual(test.viewModel.isUserConnected, true)
			XCTAssertEqual(test.viewModel.user?.mail, "TEST")
		}
	}
}
