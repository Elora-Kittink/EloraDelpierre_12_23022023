//
//  APIWorker.swift
//  FosterApp
//
//  Created by Elora on 22/05/2023.
//

import Foundation

/// `APIWorker` is responsible for handling API calls.
struct APIWorker {
    
	/// Fetches nursing advices from a specified URL, typically from a GitHub repository.
	/// - Parameter url: The URL from which to fetch the advices.
	/// - Returns: An `AdvicesResponse` object containing the fetched advices.
	/// - Note: This function performs an asynchronous network request to retrieve the data.
    func fetchAllAdvices(url: URL) async -> AdvicesResponse {
        
        do {
			// Perform the network request to fetch data
            let (data, _) = try await URLSession.shared.data(from: url)
			// Decode the JSON data into `AdvicesResponse` model
            let _data = try JSONDecoder().decode(AdvicesResponse.self, from: data)
            
            return _data
        } catch {
			// Handle any errors that occur during the fetch and decoding process
            print(error)
			// Return an empty `AdvicesResponse` in case of error
            return AdvicesResponse(sections: [])
        }
    }
}
