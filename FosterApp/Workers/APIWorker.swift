//
//  APIWorker.swift
//  FosterApp
//
//  Created by Elora on 22/05/2023.
//

import Foundation

struct APIWorker {
    
    func fetchAllAdvices(url: URL) async -> AdvicesResponse {
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let _data = try JSONDecoder().decode(AdvicesResponse.self, from: data)
            
            return _data
        } catch {
            print(error)
            return AdvicesResponse(sections: [])
        }
    }
}
