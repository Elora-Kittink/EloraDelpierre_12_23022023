//
//  AdvicesTests.swift
//  FosterAppTests
//
//  Created by Elora on 22/05/2023.
//

import XCTest
@testable import FosterApp

final class AdvicesTests: XCTestCase {
    
    func testAdviceFetchSucces() async throws {
        let test = await BaseTest<AdvicesViewModel, AdvicesPresenter, AdvicesInteractor>()
        
        
        await test.fire { interactor in
            DispatchQueue.main.async {
                interactor.refresh(url: AdvicesMocks.mockSucces.url)
            }
        }
        
        DispatchQueue.main.async {
            XCTAssertEqual(test.viewModel.sections?.sections.count, 5)
        }
    }
    
    func testAdvicesFetchFail() async throws {
        let test = await BaseTest<AdvicesViewModel, AdvicesPresenter, AdvicesInteractor>()
        
        await test.fire { interactor in
            DispatchQueue.main.async {
                interactor.refresh(url: AdvicesMocks.mockFail.url)
            }
            DispatchQueue.main.async {
                XCTAssert(test.viewModel.sections == nil)
            }
        }
    }
    
    func testUrlNil() async throws {
        let test = await BaseTest<AdvicesViewModel, AdvicesPresenter, AdvicesInteractor>()
        
        await test.fire { interactor in
            DispatchQueue.main.async {
                interactor.refresh(url: nil)
            }
            DispatchQueue.main.async {
                XCTAssert(test.viewModel.sections == nil)
            }
        }
    }
}
