//
//  KittenCardTests.swift
//  FosterAppTests
//
//  Created by Elora on 22/05/2023.
//

import XCTest
import CoreDataUtilsKit
@testable import FosterApp


final class KittenCardTests: XCTestCase {
	
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
	let userWorker = UserWorker()
	let date = Date(timeIntervalSinceNow: TimeInterval(floatLiteral: 10))
	let user = User(mail: "TEST", id: "TEST", name: "TEST")
	var fetchedLitter: Litter!
	var litterId: String!
	var kittenCreated: Kitten?
	
	override func setUpWithError() throws {
		try super.setUpWithError()
		try? CoreDataManager.default.dropDatabase()
		do {
			let litter = try XCTUnwrap(self.DBworker.createNewLitter(rescueDate: date, user: self.user))
			self.fetchedLitter = try XCTUnwrap(self.DBworker.fetchLitterFromId(litterId: litter.id ?? ""))
			self.litterId = try XCTUnwrap(fetchedLitter.id)
		} catch {
			XCTFail(error.localizedDescription)
		}
	}
	
// MARK: Modal compose kitten tests
	
	func testSuccessComposeKitten() async throws {
		let test = await BaseTest<KittenCardModalViewModel, KittenCardModalPresenter, KittenCardModalInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				self.kittenCreated = interactor.composeKitten(litter: self.fetchedLitter,
										 firstName: "UT",
										 secondName: "UT",
										 birthdate: nil,
										 sex: "UT",
										 color: "UT",
										 rescueDate: nil,
										 comment: "UT",
										 isAdopted: false,
															  microship: nil,
															  tattoo: nil,
										 vaccines: nil,
										 adopters: nil,
										 weightHistory: nil,
										 isEdited: false,
										 kittenId: nil,
										 isAlive: true)
			}
		}
//		 dead code?
		let DBlitters = try XCTUnwrap(DBworker.fetchAllLitters(user: user))
		
		DispatchQueue.main.async {
			XCTAssertEqual(self.kittenCreated?.firstName, "UT")
		}
	}
	
	func testSuccessCreateKitten() async throws {
		let test = await BaseTest<KittenCardModalViewModel, KittenCardModalPresenter, KittenCardModalInteractor>()
		
		let testKitten = Kitten(id: "Test",
								litter: self.fetchedLitter,
								firstName: "Test",
								secondName: "Test",
								birthdate: nil,
								sex: nil,
								color: nil,
								rescueDate: nil,
								siblings: nil,
								comment: "Test",
								isAdopted: false,
								microship: nil,
								tattoo: nil,
								vaccines: nil,
								adopters: nil,
								weighingHistory: nil,
								isAlive: true)
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.saveKitten(isNewKitten: true, kitten: testKitten, litter: self.fetchedLitter)
			}
		}
		let kittens = try XCTUnwrap(DBworker.fetchAllKittensLitter(litterId: self.litterId))
		let kitten = try XCTUnwrap(kittens.first)
		DispatchQueue.main.async {
			XCTAssertEqual(kitten.firstName, "Test")
		}
	}
	
	func testFailCreateKitten() async throws {
		let test = await BaseTest<KittenCardModalViewModel, KittenCardModalPresenter, KittenCardModalInteractor>()
		
		let litterFail = Litter(isOngoing: true, rescueDate: "some date")
		
		let testKitten = Kitten(id: "Test",
								litter: self.fetchedLitter,
								firstName: "Test",
								secondName: "Test",
								birthdate: nil,
								sex: nil,
								color: nil,
								rescueDate: nil,
								siblings: nil,
								comment: "Test",
								isAdopted: false,
								microship: nil,
								tattoo: nil,
								vaccines: nil,
								adopters: nil,
								weighingHistory: nil,
								isAlive: true)
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.saveKitten(isNewKitten: true, kitten: testKitten, litter: self.fetchedLitter)
			}
		}
		let kittens = try XCTUnwrap(DBworker.fetchAllKittensLitter(litterId: litterFail.id ?? ""))

		DispatchQueue.main.async {
			XCTAssertEqual(kittens.count, 0)
		}
	}
	
	func testSuccesUpdateKitten() async throws {
		let test = await BaseTest<KittenCardModalViewModel, KittenCardModalPresenter, KittenCardModalInteractor>()
		
		let kitten1 = Kitten(   id: "id",
								litter: self.fetchedLitter,
								firstName: "V1",
								secondName: "Test",
								birthdate: date,
								sex: nil,
								color: nil,
								rescueDate: nil,
								siblings: nil,
								comment: "Test",
								isAdopted: false,
								microship: nil,
								tattoo: nil,
								vaccines: nil,
								adopters: nil,
								weighingHistory: nil,
								isAlive: true)
		let kitten2 = Kitten(	id: "id",
								litter: self.fetchedLitter,
								firstName: "V2",
								secondName: "Test",
								birthdate: date,
								sex: nil,
								color: nil,
								rescueDate: nil,
								siblings: nil,
								comment: "Test",
								isAdopted: false,
								microship: nil,
								tattoo: nil,
								vaccines: nil,
								adopters: nil,
								weighingHistory: nil,
								isAlive: true)
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.saveKitten(isNewKitten: true, kitten: kitten1, litter: self.fetchedLitter)
				interactor.saveKitten(isNewKitten: false, kitten: kitten2, litter: self.fetchedLitter)
				do {
					let kittens = try XCTUnwrap(self.DBworker.fetchAllKittensLitter(litterId: self.fetchedLitter.id ?? ""))
					self.kittenCreated = try XCTUnwrap(kittens.first)
				} catch {
					XCTFail(error.localizedDescription)
				}
				
				DispatchQueue.main.async {
					XCTAssertEqual(self.kittenCreated?.firstName, "V2")
				}
			}
		}
	}
	
	func testFailUpdateKitten() async throws {
		let test = await BaseTest<KittenCardModalViewModel, KittenCardModalPresenter, KittenCardModalInteractor>()
		
		let kitten1 = Kitten(   id: "id",
								litter: self.fetchedLitter,
								firstName: "V1",
								secondName: "Test",
								birthdate: date,
								sex: nil,
								color: nil,
								rescueDate: nil,
								siblings: nil,
								comment: "Test",
								isAdopted: false,
								microship: nil,
								tattoo: nil,
								vaccines: nil,
								adopters: nil,
								weighingHistory: nil,
								isAlive: true)
		
		let kitten2 = Kitten(	id: "notSameId",
								litter: self.fetchedLitter,
								firstName: "V2",
								secondName: "Test",
								birthdate: date,
								sex: nil,
								color: nil,
								rescueDate: nil,
								siblings: nil,
								comment: "Test",
								isAdopted: false,
								microship: nil,
								tattoo: nil,
								vaccines: nil,
								adopters: nil,
								weighingHistory: nil,
								isAlive: true)
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.saveKitten(isNewKitten: true, kitten: kitten1, litter: self.fetchedLitter)
				interactor.saveKitten(isNewKitten: false, kitten: kitten2, litter: self.fetchedLitter)
				do {
					let kittens = try XCTUnwrap(self.DBworker.fetchAllKittensLitter(litterId: self.fetchedLitter.id ?? ""))
					self.kittenCreated = try XCTUnwrap(kittens.first)
				} catch {
					XCTFail(error.localizedDescription)
				}
				
				DispatchQueue.main.async {
					XCTAssertEqual(self.kittenCreated?.firstName, "V1")
				}
			}
		}
	}
	
	func testSuccessGetKittenFromId() async throws {
		let test = await BaseTest<KittenCardModalViewModel, KittenCardModalPresenter, KittenCardModalInteractor>()
		
		let testKitten = Kitten(id: "Test",
								litter: self.fetchedLitter,
								firstName: "Test",
								secondName: "Test",
								birthdate: nil,
								sex: nil,
								color: nil,
								rescueDate: nil,
								siblings: nil,
								comment: "Test",
								isAdopted: false,
								microship: nil,
								tattoo: nil,
								vaccines: nil,
								adopters: nil,
								weighingHistory: nil,
								isAlive: true)
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.saveKitten(isNewKitten: true, kitten: testKitten, litter: self.fetchedLitter)
			}
		}
		let kittens = try XCTUnwrap(DBworker.fetchAllKittensLitter(litterId: self.litterId))
		let kittenId = try XCTUnwrap(kittens.first?.id)
		
		DispatchQueue.main.async {
			do {
				self.kittenCreated = try XCTUnwrap(self.DBworker.fetchKittenFromId(kittenId: kittenId))
			} catch {
				XCTFail(error.localizedDescription)
			}
		}
		
		DispatchQueue.main.async {
			XCTAssertEqual(self.kittenCreated?.firstName, testKitten.firstName)
		}
	}
	
	func testFailGetKittenFromId() async throws {
		let test = await BaseTest<KittenCardModalViewModel, KittenCardModalPresenter, KittenCardModalInteractor>()
		
		let testKitten = Kitten(id: "Test",
								litter: self.fetchedLitter,
								firstName: "Test",
								secondName: "Test",
								birthdate: nil,
								sex: nil,
								color: nil,
								rescueDate: nil,
								siblings: nil,
								comment: "Test",
								isAdopted: false,
								microship: nil,
								tattoo: nil,
								vaccines: nil,
								adopters: nil,
								weighingHistory: nil,
								isAlive: true)
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.saveKitten(isNewKitten: true, kitten: testKitten, litter: self.fetchedLitter)
			}
		}
		
		DispatchQueue.main.async {
				self.kittenCreated = self.DBworker.fetchKittenFromId(kittenId: "bad id")
		}
		
		DispatchQueue.main.async {
			XCTAssertEqual(self.kittenCreated, nil)
		}
	}
	
	func testSuccessRefreshEditing() async throws {
		let test = await BaseTest<KittenCardModalViewModel, KittenCardModalPresenter, KittenCardModalInteractor>()
		
		let testKitten = Kitten(id: "Test",
								litter: self.fetchedLitter,
								firstName: "Test",
								secondName: "Test",
								birthdate: nil,
								sex: nil,
								color: nil,
								rescueDate: nil,
								siblings: nil,
								comment: "Test",
								isAdopted: false,
								microship: nil,
								tattoo: nil,
								vaccines: nil,
								adopters: nil,
								weighingHistory: nil,
								isAlive: true)
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.refresh(isEdititngMode: true, isCreatingMode: false, kitten: testKitten)
			}
			
			DispatchQueue.main.async {
				XCTAssertEqual(test.viewModel.firstName, testKitten.firstName)
				XCTAssertEqual(test.viewModel.comment, testKitten.comment)
				XCTAssertEqual(test.viewModel.secondName, testKitten.secondName)
			}
		}
	}
	
	func testSuccessRefreshDisplaying() async throws {
		let test = await BaseTest<KittenCardModalViewModel, KittenCardModalPresenter, KittenCardModalInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.refresh(isEdititngMode: false, isCreatingMode: true, kitten: nil)
			}
			
			DispatchQueue.main.async {
				XCTAssertEqual(test.viewModel.firstName, "")
				XCTAssertEqual(test.viewModel.comment, "")
				XCTAssertEqual(test.viewModel.secondName, "")
			}
		}
	}
	
	func testSuccessRefresh() async throws {
		let test = await BaseTest<KittenCardViewModel, KittenCardPresenter, KittenCardInteractor>()
		
		let testKitten = Kitten(id: "Test",
								litter: self.fetchedLitter,
								firstName: "Test",
								secondName: "Test",
								birthdate: nil,
								sex: nil,
								color: nil,
								rescueDate: nil,
								siblings: nil,
								comment: "Test",
								isAdopted: false,
								microship: nil,
								tattoo: nil,
								vaccines: nil,
								adopters: nil,
								weighingHistory: nil,
								isAlive: true)
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.refresh(kitten: testKitten, litter: self.fetchedLitter)
			}
			
			DispatchQueue.main.async {
				XCTAssertEqual(test.viewModel.firstName, testKitten.firstName)
				XCTAssertEqual(test.viewModel.comment, testKitten.comment)
				XCTAssertEqual(test.viewModel.secondName, testKitten.secondName)
			}
		}
	}
}
