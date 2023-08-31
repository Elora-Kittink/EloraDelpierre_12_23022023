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
    let user = User(mail: "UT", id: "UT", name: "UT")
    let litter = Litter(isOngoing: true, rescueDate: "UT")
	let date = Date(timeIntervalSinceNow: TimeInterval(floatLiteral: 10))
    let worker = DBWorker()
    
    func testFailNoUser() async throws {
        try CoreDataManager.default.dropDatabase()
        let test = await BaseTest<LitterHistoryViewModel, LitterHistoryPresenter, LitterHistoryInteractor>()
        
        await test.fire { interactor in
            DispatchQueue.main.async {
                interactor.refresh(user: User(mail: "", id: "", name: ""))
            }
        }
        
        DispatchQueue.main.async {
            XCTAssert(test.viewModel.litters == [])
        }
    }
    
    func testSuccessFetchAll() async throws {
        try CoreDataManager.default.dropDatabase()
        
        let DBUser = worker.createUser(name: "UT", mail: "UT", id: "UT")
        let DBLitter = worker.createNewLitter(rescueDate: date, user: user)

        try CoreDataManager.default.save()

        let test = await BaseTest<LitterHistoryViewModel, LitterHistoryPresenter, LitterHistoryInteractor>()
        
        await test.fire { interactor in
            DispatchQueue.main.async {
                interactor.refresh(user: self.user)
            }
        }
        
        DispatchQueue.main.async {
            XCTAssertEqual(test.viewModel.litters?.count, 1)
        }
    }
    
    func testSuccesRefreshCell() async throws {
        try CoreDataManager.default.dropDatabase()
        
        let DBUser = worker.createUser(name: "UT", mail: "UT", id: "UT")
        
        let DBLitter = try XCTUnwrap(worker.createNewLitter(rescueDate: date, user: user))
        
		let kitten = Kitten(id: "UT",
                            litter: DBLitter,
                            firstName: "Test",
                            secondName: nil,
                            birthdate: nil,
                            sex: nil,
                            color: nil,
                            rescueDate: nil,
                            siblings: nil,
                            comment: nil,
                            isAdopted: false,
                            microship: nil,
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
            XCTAssertEqual(test.viewModel.kittenList, "Test")
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
