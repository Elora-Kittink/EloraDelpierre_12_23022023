//
//  APIWorker.swift
//  FosterApp
//
//  Created by Elora on 22/05/2023.
//

import Foundation

struct APIWorker {
    
    func fetchAllAdvices() async throws -> AdvicesResponse {
        
        let data = try await APIRequest().response(AdvicesResponse.self)
        
        return data
    }
}
