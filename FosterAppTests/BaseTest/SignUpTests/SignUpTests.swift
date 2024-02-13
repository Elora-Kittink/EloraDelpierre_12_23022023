//
//  SignUpTests.swift
//  FosterAppTests
//
//  Created by Elora on 06/06/2023.
//

import XCTest
import CoreDataUtilsKit
@testable import FosterApp

final class SignUpTests: XCTestCase {
	
	struct MockUserWorker: UserWorkerProtocol {
		func logOut() {
			
		}
		
		func deleteAccount() {
			
		}
		
		func userConnected() async throws -> FosterApp.User? {
			User(mail: "MAIL", id: "ID", name: "NAME")
		}
		
		func signUp(mail: String, password: String) async throws -> FosterApp.User {
			User(mail: "MAIL", id: "ID", name: "NAME")
		}
		
		
		func login(email: String, password: String) async throws -> FosterApp.User {
			User(mail: "MAIL", id: "ID", name: "NAME")
		}
	}
	
	override func setUpWithError() throws {
		try super.setUpWithError()
		try? CoreDataManager.default.dropDatabase()
	}
	
	func testSuccessSignup() async throws {
		
		let test = await BaseTest<SignUpViewModel, SignUpPresenter, SignUpInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.userWorker = MockUserWorker()
				interactor.signUp(mail: "", name: "", password: "")
			}
		}
		
		DispatchQueue.main.async {
			XCTAssertEqual(test.viewModel.userSignedIn?.id, "ID")
			XCTAssertEqual(test.viewModel.userSignedIn?.mail, "MAIL")
			XCTAssertEqual(test.viewModel.userSignedIn?.name, "NAME")
		}
	}
	
	func testFailLogUser() async throws {
		
		let test = await BaseTest<SignUpViewModel, SignUpPresenter, SignUpInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.userWorker = MockUserWorker()
				interactor.signUp(mail: nil, name: nil, password: nil)
			}
			
			DispatchQueue.main.async {
				XCTAssertEqual(test.viewModel.userSignedIn, nil)
			}
		}
	}
}
