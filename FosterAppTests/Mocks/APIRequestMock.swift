//
//  APIRequestMock.swift
//  FosterAppTests
//
//  Created by Elora on 24/05/2023.
//

import Foundation

enum AdvicesMocks: String, Codable {
    
    case mockFail = "mock_fail"
    case mockSucces = "mock_success"
    
    var url: URL? {
        switch self {
        case .mockFail:
            return Bundle.main.url(forResource: "AdvicesResponseFail",
                            withExtension: "json")
            
        case .mockSucces:
            return Bundle.main.url(forResource: "AdviceMockSuccess",
                            withExtension: "json")
        }
    }
}
