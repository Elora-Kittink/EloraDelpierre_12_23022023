//
//  LitterTests.swift
//  FosterAppTests
//
//  Created by Elora on 22/05/2023.
//

import XCTest
import CoreDataUtilsKit
@testable import FosterApp


final class LitterTests: XCTestCase {
	let worker = DBWorker()
//	let user = User(mail: "UT", id: "UT", name: "UT")
	let litter = Litter(isOngoing: true, rescueDate: "UT")
	let date = Date(timeIntervalSinceNow: TimeInterval(floatLiteral: 10))
	var litterFound: Litter?
	var fetchedUser: User!
	
	
	override func setUp() {
		super.setUp()
		try? CoreDataManager.default.dropDatabase()
		do {
			let createdUser = try XCTUnwrap(worker.createUser(name: "UT", mail: "UT", id: "UT"))
			self.fetchedUser = try XCTUnwrap(self.worker.fetchUser(id: createdUser.id))
		} catch {
			XCTFail(error.localizedDescription)
		}
	}
	
	//	test func createLitter
	
	func testSuccesCreateLitter() async throws {
		
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.createLitter(user: self.fetchedUser, rescueDate: self.date)
			}
		}
		
		let DBlitters = try XCTUnwrap(worker.fetchAllLitters(userId: self.fetchedUser.id))
		
		DispatchQueue.main.async {
			XCTAssertEqual(DBlitters.count, 1)
		}
	}
	
	func testInteractorFailCreateLitter() async throws {
		
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.createLitter(user: self.fetchedUser, rescueDate: nil)
			}
		}
		
		let DBlitters = try XCTUnwrap(worker.fetchAllLitters(userId: self.fetchedUser.id))
		
		DispatchQueue.main.async {
			XCTAssertEqual(DBlitters.count, 0)
		}
	}
	
	func testDBFailCreateLitter() async throws {
		let failUser = User(mail: "TestFail", id: "TestFail", name: "TestFail")
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.createLitter(user: failUser	, rescueDate: self.date)
			}
		}
		
		let DBlitters = try XCTUnwrap(worker.fetchAllLitters(userId: self.fetchedUser.id))
		
		DispatchQueue.main.async {
			XCTAssertEqual(DBlitters.count, 0)
		}
	}
	
	//	test func archiveLitter
	
	func testSuccesArchiveLitter() async throws {
	
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.createLitter(user: self.fetchedUser, rescueDate: self.date)
				
				do {
					let allLitters = try XCTUnwrap(self.worker.fetchAllLitters(userId: self.fetchedUser.id))
					let litterId = try XCTUnwrap(allLitters.first?.id)
					interactor.archiveLitter(litterId: litterId)
					self.litterFound = try XCTUnwrap(self.worker.fetchLitterFromId(litterId: litterId))
				} catch {
					XCTFail(error.localizedDescription)
				}
			}
		}
		
		DispatchQueue.main.async {
			do {
				let _litterFound = try XCTUnwrap(self.litterFound)
				XCTAssertEqual(_litterFound.isOngoing, false)
			} catch {
				
				XCTFail(error.localizedDescription)
			}
		}
	}
	
	func testFailArchiveLitter() async throws {
		
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.createLitter(user: self.fetchedUser, rescueDate: self.date)
				
				do {
					let allLitters = try XCTUnwrap(self.worker.fetchAllLitters(userId: self.fetchedUser.id))
					let litterId = try XCTUnwrap(allLitters.first?.id)
					interactor.archiveLitter(litterId: "badID")
					self.litterFound = try XCTUnwrap(self.worker.fetchLitterFromId(litterId: litterId))
				} catch {
					XCTFail(error.localizedDescription)
				}
			}
		}
		
		DispatchQueue.main.async {
			do {
				let _litterFound = try XCTUnwrap(self.litterFound)
				XCTAssertEqual(_litterFound.isOngoing, true)
			} catch {
				XCTFail(error.localizedDescription)
			}
		}
	}
	
	//	tests makeFavorite
	
	func testSuccessMakeFavorite() async throws {
		
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.createLitter(user: self.fetchedUser, rescueDate: self.date)
				
				do {
					let allLitters = try XCTUnwrap(self.worker.fetchAllLitters(userId: self.fetchedUser.id))
					let litterId = try XCTUnwrap(allLitters.first?.id)
					interactor.makeFavorite(litterId: litterId)
					self.litterFound = try XCTUnwrap(self.worker.fetchLitterFromId(litterId: litterId))
				} catch {
					XCTFail(error.localizedDescription)
				}
			}
		}
		
		DispatchQueue.main.async {
			do {
				let _litterFound = try XCTUnwrap(self.litterFound)
				XCTAssertEqual(_litterFound.isFavorite, true)
			} catch {
				XCTFail(error.localizedDescription)
			}
		}
	}
	
	func testFailMakeFavorite() async throws {
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.createLitter(user: self.fetchedUser, rescueDate: self.date)
				
				do {
					let allLitters = try XCTUnwrap(self.worker.fetchAllLitters(userId: self.fetchedUser.id))
					let litterId = try XCTUnwrap(allLitters.first?.id)
					interactor.makeFavorite(litterId: "badID")
					self.litterFound = try XCTUnwrap(self.worker.fetchLitterFromId(litterId: litterId))
				} catch {
					XCTFail(error.localizedDescription)
				}
			}
		}
		
		DispatchQueue.main.async {
			do {
				let _litterFound = try XCTUnwrap(self.litterFound)
				XCTAssertEqual(_litterFound.isFavorite, false)
			} catch {
				XCTFail(error.localizedDescription)
			}
		}
	}
	
	//	tests display
	
	func testSuccessDisplayDisplayingMode() async throws {
		
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.createLitter(user: self.fetchedUser, rescueDate: self.date)
				
				do {
					let allLitters = try XCTUnwrap(self.worker.fetchAllLitters(userId: self.fetchedUser.id))
					let litterId = try XCTUnwrap(allLitters.first?.id)
					self.litterFound = try XCTUnwrap(self.worker.fetchLitterFromId(litterId: litterId))
					interactor.refresh(litterId: litterId)
				} catch {
					XCTFail(error.localizedDescription)
				}
			}
		}
		DispatchQueue.main.async {
			XCTAssertEqual(test.viewModel.isEditing, false)
			XCTAssertEqual(test.viewModel.isDisplaying, true)
			XCTAssertEqual(test.viewModel.isCreatingNew, false)
			XCTAssertEqual(test.viewModel.saveBtnHidden, true)
			XCTAssertEqual(test.viewModel.rescueDate, self.date.toString(format: "dd/MM/yyyy"))
		}
	}
	
	func testFailDisplay() async throws {
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.createLitter(user: self.fetchedUser, rescueDate: self.date)
					interactor.refresh(litterId: "badId")
			}
		}
		DispatchQueue.main.async {
			XCTAssertEqual(test.viewModel.rescueDate, nil)
		}
	}
	
	func testDisplayEditing() async throws {
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
					interactor.diplayMode(isEditing: true, isCreating: false, isDisplaying: false, litterId: "someId")
			}
		}
		
		DispatchQueue.main.async {
			XCTAssertEqual(test.viewModel.isEditing, true)
			XCTAssertEqual(test.viewModel.isDisplaying, false)
			XCTAssertEqual(test.viewModel.isCreatingNew, false)
		}
	}
	
	func testDisplayCreating() async throws {
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
					interactor.diplayMode(isEditing: false, isCreating: true, isDisplaying: false, litterId: "someId")
			}
		}
		
		DispatchQueue.main.async {
			XCTAssertEqual(test.viewModel.isEditing, false)
			XCTAssertEqual(test.viewModel.isDisplaying, false)
			XCTAssertEqual(test.viewModel.isCreatingNew, true)
		}
	}
	
	func testDisplayDisplaying() async throws {
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
					interactor.diplayMode(isEditing: false, isCreating: false, isDisplaying: true, litterId: "someId")
			}
		}
		
		DispatchQueue.main.async {
			XCTAssertEqual(test.viewModel.isEditing, false)
			XCTAssertEqual(test.viewModel.isDisplaying, true)
			XCTAssertEqual(test.viewModel.isCreatingNew, false)
			XCTAssertEqual(test.viewModel.id, "someId")
		}
	}
}
