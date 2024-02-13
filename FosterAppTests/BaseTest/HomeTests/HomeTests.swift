//
//  HomeTests.swift
//  FosterAppTests
//
//  Created by Elora on 22/05/2023.
//

import XCTest
import CoreDataUtilsKit
@testable import FosterApp

//final class HomeTests: XCTestCase {
//	
//	struct MockUserWorker: UserWorkerProtocol {
//		func userConnected() async throws -> FosterApp.User? {
//			FosterApp.User(mail: "TEST", id: "ID", name: "TEST")
//		}
//		
//		func signUp(mail: String, password: String) async throws -> FosterApp.User {
//			FosterApp.User(mail: "TEST", id: "ID", name: "TEST")
//		}
//		
//		func login(email: String, password: String) async throws -> FosterApp.User {
//			User(mail: "TEST", id: "ID", name: "TEST")
//		}
//	}
//	
//	let worker = DBWorker()
//	
//	override func setUpWithError() throws {
//		try super.setUpWithError()
//		try? CoreDataManager.default.dropDatabase()
//	}
//	
//	func testSuccessLogUser() async throws {
//		
//		let test = await BaseTest<HomeViewModel, HomePresenter, HomeInteractor>()
//		
//		DispatchQueue.main.async {
//			_ = self.worker.createUser(name: "TEST", mail: "TEST", id: "ID")
//		}
//		
//		await test.fire { interactor in
//			DispatchQueue.main.async {
//				interactor.userWorker = MockUserWorker()
//				interactor.userIsConnected()
//			}
//		}
//		
//		DispatchQueue.main.async {
//			XCTAssertEqual(test.viewModel.user?.id, "ID")
//			XCTAssertEqual(test.viewModel.user?.mail, "TEST")
//			XCTAssertEqual(test.viewModel.user?.name, "TEST")
//		}
//	}
//	
//	func testFailFetchUserLogged() async throws {
//		
//		let test = await BaseTest<HomeViewModel, HomePresenter, HomeInteractor>()
//		
//		DispatchQueue.main.async {
//			_ = self.worker.createUser(name: "bad name", mail: "bad mail", id: "bad id")
//		}
//		
//		await test.fire { interactor in
//			DispatchQueue.main.async {
//				interactor.userWorker = MockUserWorker()
//				interactor.userIsConnected()
//			}
//		}
//		
//		DispatchQueue.main.async {
//			XCTAssertEqual(test.viewModel.user, nil)
//			XCTAssertEqual(test.viewModel.isUserConnected, false)
//		}
//	}
//}
