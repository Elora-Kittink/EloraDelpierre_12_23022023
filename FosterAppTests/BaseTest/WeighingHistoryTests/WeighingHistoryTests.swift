//
//  WeighingHistoryTests.swift
//  FosterAppTests
//
//  Created by Elora on 18/08/2023.
//

import XCTest
import CoreDataUtilsKit
@testable import FosterApp

final class WeighingHistoryTests: XCTestCase {
    let worker = DBWorker()
    let date = Date(timeIntervalSinceNow: TimeInterval(floatLiteral: 10))
//    var fetchedUser: User!
    var fetchedLitter: Litter!
    var litterId: String!
    var kittenCreated: Kitten!
    var weighingCreated: Weighing?
	let user = User(mail: "UT", id: "UT", name: "UT")
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        try? CoreDataManager.default.dropDatabase()
        do {
//            let createdUser = try XCTUnwrap(worker.createUser(name: "UT", mail: "UT", id: "UT"))
//            self.fetchedUser = try XCTUnwrap(self.worker.fetchUser(id: createdUser.id))
			let litter = try XCTUnwrap(self.worker.createNewLitter(rescueDate: date, user: self.user))
            self.fetchedLitter = try XCTUnwrap(self.worker.fetchLitterFromId(litterId: litter.id ?? ""))
            self.litterId = try XCTUnwrap(fetchedLitter.id)
            self.kittenCreated = try XCTUnwrap(self.worker.createKitten(kitten: Kitten(id: "TEST",
                                                                                       litter: self.fetchedLitter,
                                                                                       firstName: "TEST",
                                                                                       secondName: "TEST",
                                                                                       birthdate: self.date,
                                                                                       sex: "TEST",
                                                                                       color: "TEST",
                                                                                       rescueDate: nil,
                                                                                       siblings: nil,
                                                                                       comment: nil,
                                                                                       isAdopted: false,
																					   microship: nil,
																					   tattoo: nil,
                                                                                       vaccines: nil,
                                                                                       adopters: nil,
                                                                                       weighingHistory: nil, 
																					   isAlive: true),
																		litter: self.fetchedLitter))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testSuccesComposeWheighing() async throws {
        let test = await BaseTest<AddWeightViewModel, AddWeightPresenter, AddWeightInteractor>()
        
        await test.fire { interactor in
            DispatchQueue.main.async {
                self.weighingCreated = interactor.composeWeighing(weightId: "weightId", 
																  kittenWeight: "kittenWeight",
																  mealWeight: "mealWeight",
																  date: self.date,
																  isEdition: false)
            }
            
            DispatchQueue.main.async {
                XCTAssertEqual(self.weighingCreated?.kittenWeight, "kittenWeight")
                XCTAssertEqual(self.weighingCreated?.mealWeight, "mealWeight")
            }
        }
    }
   
    func testSuccessCreateWeighing() async throws {
        let test = await BaseTest<AddWeightViewModel, AddWeightPresenter, AddWeightInteractor>()
        
        let testWeighing = Weighing(id: UUID().uuidString, date: self.date, kittenWeight: "100", mealWeight: "10")
        let testWeighing2 = Weighing(id: UUID().uuidString, date: self.date, kittenWeight: "200", mealWeight: "20")
        
        await test.fire { interactor in
            DispatchQueue.main.async {
                 interactor.saveWeighing(isNew: true, weighing: testWeighing, kitten: self.kittenCreated)
                 interactor.saveWeighing(isNew: true, weighing: testWeighing2, kitten: self.kittenCreated)
            }
        }
        
        let weighings = try XCTUnwrap(worker.fetchWeighingFromKittenId(kittenId: self.kittenCreated.id ?? ""))
       
        
       
        let firstWeighing = try XCTUnwrap(weighings.first)
        let lastWeighing = try XCTUnwrap(weighings.last)
        
        DispatchQueue.main.async {
            XCTAssertEqual(firstWeighing.kittenWeight, "100")
            XCTAssertEqual(lastWeighing.kittenWeight, "200")
            XCTAssertEqual(firstWeighing.mealWeight, "10")
            XCTAssertEqual(lastWeighing.mealWeight, "20")
        }
    }
    
   func testFailCreateWeighing() async throws {
       let test = await BaseTest<AddWeightViewModel, AddWeightPresenter, AddWeightInteractor>()
       
       let testWeighing = Weighing(id: nil, date: self.date, kittenWeight: "100", mealWeight: "10")
       
       await test.fire { interactor in
           DispatchQueue.main.async {
                interactor.saveWeighing(isNew: true, weighing: testWeighing, kitten: self.kittenCreated)
           }
       }
       
       let weighings = try XCTUnwrap(worker.fetchWeighingFromKittenId(kittenId: self.kittenCreated.id ?? ""))
       
       DispatchQueue.main.async {
           XCTAssertTrue(weighings.isEmpty)
       }
    }
    
    func testSuccessUpdateWeighing() async throws {
        let test = await BaseTest<AddWeightViewModel, AddWeightPresenter, AddWeightInteractor>()
        
        let testWeighing = Weighing(id: "id", date: self.date, kittenWeight: "100", mealWeight: "10")
        let testWeighing2 = Weighing(id: "id", date: self.date, kittenWeight: "200", mealWeight: "20")
        
        await test.fire { interactor in
            DispatchQueue.main.async {
                 interactor.saveWeighing(isNew: true, weighing: testWeighing, kitten: self.kittenCreated)
                 interactor.saveWeighing(isNew: false, weighing: testWeighing2, kitten: self.kittenCreated)
            }
        }
        
        let weighings = try XCTUnwrap(worker.fetchWeighingFromKittenId(kittenId: self.kittenCreated.id ?? ""))
        
        DispatchQueue.main.async {
            XCTAssertEqual(weighings.first?.kittenWeight, "200")
            XCTAssertEqual(weighings.first?.mealWeight, "20")
        }
    }
    
    func testFailUpdateWeighing() async throws {
        let test = await BaseTest<AddWeightViewModel, AddWeightPresenter, AddWeightInteractor>()
        
        let testWeighing = Weighing(id: "id", date: self.date, kittenWeight: "100", mealWeight: "10")
        let testWeighing2 = Weighing(id: "notSameId", date: self.date, kittenWeight: "200", mealWeight: "20")
        
        await test.fire { interactor in
            DispatchQueue.main.async {
                 interactor.saveWeighing(isNew: true, weighing: testWeighing, kitten: self.kittenCreated)
                 interactor.saveWeighing(isNew: false, weighing: testWeighing2, kitten: self.kittenCreated)
            }
        }
        
        let weighings = try XCTUnwrap(worker.fetchWeighingFromKittenId(kittenId: self.kittenCreated.id ?? ""))
        
        DispatchQueue.main.async {
            XCTAssertEqual(weighings.first?.kittenWeight, "100")
            XCTAssertEqual(weighings.first?.mealWeight, "10")
        }
    }
    
    func testRefresh() async throws {
        
        let testWeighing = Weighing(id: "id", date: self.date, kittenWeight: "100", mealWeight: "10")
        
        let weighing = worker.createWeighing(kitten: self.kittenCreated, weighing: testWeighing)
        
        let test = await BaseTest<WeighingListViewModel, WeighingListPresenter, WeighingListInteractor>()
        
        await test.fire { interactor in
            DispatchQueue.main.async {
                interactor.refresh(kitten: self.kittenCreated)
            }
        }
        
        DispatchQueue.main.async {
            XCTAssertEqual(test.viewModel.weights?.first?.kittenWeight, "100")
        }
    }
}
