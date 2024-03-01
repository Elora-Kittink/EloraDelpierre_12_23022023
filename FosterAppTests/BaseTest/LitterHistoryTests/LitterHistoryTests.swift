//
//  LitterHistoryTests.swift
//  FosterAppTests
//
//  Created by Elora on 22/05/2023.
//

import XCTest
import CoreDataUtilsKit
@testable import FosterApp

final class LitterHistoryTests: XCTestCase {
	
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
			FosterApp.User(mail: "TEST", id: "TEST", name: "TEST")
		}
		
		func userConnected() async throws -> FosterApp.User? {
			FosterApp.User(mail: "TEST", id: "TEST", name: "TEST")
		}
		
		func signUp(mail: String, password: String) async throws -> FosterApp.User {
			FosterApp.User(mail: "TEST", id: "TEST", name: "TEST")
		}
		
		func login(email: String, password: String) async throws -> FosterApp.User {
			User(mail: "TEST", id: "TEST", name: "TEST")
		}
	}
	
    let user = User(mail: "TEST", id: "TEST", name: "TEST")
    let litter = Litter(isOngoing: true, rescueDate: "TEST")
	let date = Date(timeIntervalSinceNow: TimeInterval(floatLiteral: 10))
    let worker = DBWorker()
    
//	override func setUpWithError() throws {
//		super.setUp()
//		try? CoreDataManager.default.dropDatabase()
//		worker.createNewLitter(rescueDate: date, user: self.user)
//	}
	
//    func testFailNoUser() async throws {
//        try CoreDataManager.default.dropDatabase()
//        let test = await BaseTest<LitterHistoryViewModel, LitterHistoryPresenter, LitterHistoryInteractor>()
//        
//        await test.fire { interactor in
//            DispatchQueue.main.async {
//                interactor.refresh(user: User(mail: "", id: "", name: ""))
//            }
//        }
//        
//        DispatchQueue.main.async {
//            XCTAssert(test.viewModel.litters == [])
//        }
//    }
    
	
    func testSuccessFetchAll() async throws {
        try CoreDataManager.default.dropDatabase()

        try CoreDataManager.default.save()

//		worker.createNewLitter(rescueDate: date, user: self.user)
		
        let test = await BaseTest<LitterHistoryViewModel, LitterHistoryPresenter, LitterHistoryInteractor>()
        
        await test.fire { interactor in
            DispatchQueue.main.async {
				self.worker.createNewLitter(rescueDate: self.date, user: self.user)
				interactor.userWorker = MockUserWorker()
                interactor.refresh()
            }
        }
        
        DispatchQueue.main.async {
            XCTAssertEqual(test.viewModel.litters?.count, 1)
        }
    }
    
    func testSuccesRefreshCell() async throws {
        try CoreDataManager.default.dropDatabase()
        
		let DBLitter = try XCTUnwrap(worker.createNewLitter(rescueDate: date, user: self.user))
        
		let kitten = Kitten(id: "TEST",
                            litter: DBLitter,
                            firstName: "TEST",
                            secondName: nil,
                            birthdate: nil,
                            sex: nil,
                            color: nil,
                            rescueDate: nil,
                            siblings: nil,
                            comment: nil,
                            isAdopted: false,
							microship: nil,
							tattoo: nil,
                            vaccines: nil,
                            adopters: nil,
                            weighingHistory: nil,
                            isAlive: true)
        
        _ = worker.createKitten(kitten: kitten,
                                litter: DBLitter)
        
        let dbLitterId = try XCTUnwrap(DBLitter.id)
        let _DBLitter = try XCTUnwrap(worker.fetchLitterFromId(litterId: dbLitterId))

        let test = await BaseTest<LitterHistoryViewModel, LitterHistoryPresenter, LitterHistoryInteractor>()

        await test.fire { interactor in
            DispatchQueue.main.async {
                interactor.refreshCell(litter: _DBLitter)
            }
        }

        DispatchQueue.main.async {
            XCTAssertEqual(test.viewModel.kittenList, "TEST")
        }
    }
    
    func testFailRefreshCell() async throws {
        try CoreDataManager.default.dropDatabase()
        
        let test = await BaseTest<LitterHistoryViewModel, LitterHistoryPresenter, LitterHistoryInteractor>()

        await test.fire { interactor in
            DispatchQueue.main.async {
                interactor.refreshCell(litter: nil)
            }
        }

        DispatchQueue.main.async {
            XCTAssertEqual(test.viewModel.kittenList, "Aucun chaton")
        }
    }
}
