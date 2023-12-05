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
	let litter = Litter(isOngoing: true, rescueDate: "UT")
	let date = Date(timeIntervalSinceNow: TimeInterval(floatLiteral: 10))
    let date2 = Date(timeIntervalSinceNow: TimeInterval(floatLiteral: 10))
	var litterFound: Litter?
	var fetchedUser: User!
	
	
	override func setUpWithError() throws {
		super.setUp()
		try? CoreDataManager.default.dropDatabase()
		do {
			let createdUser = try XCTUnwrap(worker.createUser(name: "UT", mail: "UT", id: "UT"))
			self.fetchedUser = try XCTUnwrap(self.worker.fetchUser(id: createdUser.id))
		} catch {
			XCTFail(error.localizedDescription)
		}
	}
		//	MARK: test func createLitter
	
	func testSuccesCreateLitter() async throws {
		
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.saveLitter(user: self.fetchedUser,
									  rescueDate: self.date,
									  isEditing: false,
									  litterId: nil)
                interactor.saveLitter(user: self.fetchedUser,
                                      rescueDate: self.date2,
                                      isEditing: false,
                                      litterId: nil)
			}
		}
		
		let DBlitters = try XCTUnwrap(worker.fetchAllLitters(userId: self.fetchedUser.id))
		
		DispatchQueue.main.async {
			XCTAssertEqual(DBlitters.count, 2)
		}
	}
	
	func testInteractorFailCreateLitter() async throws {
		
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.saveLitter(user: self.fetchedUser,
									  rescueDate: nil,
									  isEditing: false,
									  litterId: nil)
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
				interactor.saveLitter(user: failUser,
									  rescueDate: self.date,
									  isEditing: false,
									  litterId: nil)
			}
		}
		
		let DBlitters = try XCTUnwrap(worker.fetchAllLitters(userId: self.fetchedUser.id))
		
		DispatchQueue.main.async {
			XCTAssertEqual(DBlitters.count, 0)
		}
	}
	
	//	MARK: test func updateLitter
	
	func testSuccesUpdateLitter() async throws {
		let newDate = "25/12/2023"
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.saveLitter(user: self.fetchedUser,
									  rescueDate: self.date,
									  isEditing: false,
									  litterId: nil)
				do {
					let allLitters = try XCTUnwrap(self.worker.fetchAllLitters(userId: self.fetchedUser.id))
					let litterId = try XCTUnwrap(allLitters.first?.id)
					interactor.saveLitter(user: self.fetchedUser, rescueDate: newDate.toDate(format: "dd/MM/yyyy"), isEditing: true, litterId: litterId)
					self.litterFound = try XCTUnwrap(self.worker.fetchLitterFromId(litterId: litterId))
				} catch {
					XCTFail(error.localizedDescription)
				}
			}
		}
		
		let DBlitters = try XCTUnwrap(worker.fetchAllLitters(userId: self.fetchedUser.id))
		let litter = try XCTUnwrap(DBlitters.first)
		
		DispatchQueue.main.async {
			XCTAssertEqual(litter.rescueDate, newDate)
		}
	}
	
	
	func testFailUpdateLitter() async throws {
		let newDate = "25/12/2023"
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.saveLitter(user: self.fetchedUser,
									  rescueDate: self.date,
									  isEditing: false,
									  litterId: nil)
				do {
					let allLitters = try XCTUnwrap(self.worker.fetchAllLitters(userId: self.fetchedUser.id))
					let litterId = try XCTUnwrap(allLitters.first?.id)
					interactor.saveLitter(user: self.fetchedUser, rescueDate: newDate.toDate(format: "dd/MM/yyyy"), isEditing: true, litterId: nil)
					self.litterFound = try XCTUnwrap(self.worker.fetchLitterFromId(litterId: litterId))
				} catch {
					XCTFail(error.localizedDescription)
				}
			}
		}
		
		let DBlitters = try XCTUnwrap(worker.fetchAllLitters(userId: self.fetchedUser.id))
		let litter = try XCTUnwrap(DBlitters.first)
		
		DispatchQueue.main.async {
			XCTAssertEqual(litter.rescueDate, self.date.toString(format: "dd/MM/yyyy"))
		}
	}
	
	//	MARK: test func archiveLitter
	
	func testSuccesArchiveLitter() async throws {
	
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.saveLitter(user: self.fetchedUser,
									  rescueDate: self.date,
									  isEditing: false,
									  litterId: nil)
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
				interactor.saveLitter(user: self.fetchedUser,
									  rescueDate: self.date,
									  isEditing: false,
									  litterId: nil)
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
	
	//	MARK: tests makeFavorite
	
	func testSuccessMakeFavorite() async throws {
		
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.saveLitter(user: self.fetchedUser,
									  rescueDate: self.date,
									  isEditing: false,
									  litterId: nil)
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
				interactor.saveLitter(user: self.fetchedUser,
									  rescueDate: self.date,
									  isEditing: false,
									  litterId: nil)
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
	
	// MARK:	tests display
	
	func testSuccessDisplayDisplayingMode() async throws {
		
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.saveLitter(user: self.fetchedUser,
									  rescueDate: self.date,
									  isEditing: false,
									  litterId: nil)
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
				print("🐹 \(test.viewModel.rescueDate)")
				interactor.saveLitter(user: self.fetchedUser,
									  rescueDate: self.date,
									  isEditing: false,
									  litterId: nil)
				print("🐹 \(test.viewModel.rescueDate)")
				interactor.refresh(litterId: "badId")
				print("🐹 \(test.viewModel.rescueDate)")
			}
		}
		DispatchQueue.main.async {
			print("🐹 \(test.viewModel.rescueDate)")
			XCTAssertNotEqual(test.viewModel.id, "badId")
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
	
	func testFailGetLitter() async throws {
		let test = await BaseTest<LitterViewModel, LitterPresenter, LitterInteractor>()
		
		await test.fire { interactor in
			DispatchQueue.main.async {
				interactor.saveLitter(user: self.fetchedUser,
									  rescueDate: self.date,
									  isEditing: false,
									  litterId: nil)
			}
		}
		
		let DBlitters = try XCTUnwrap(worker.fetchAllLitters(userId: "someBadId"))
		
		DispatchQueue.main.async {
			XCTAssertEqual(DBlitters.count, 0)
		}
	}
}
