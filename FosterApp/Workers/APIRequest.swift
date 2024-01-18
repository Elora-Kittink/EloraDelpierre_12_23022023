//
//  APIRequest.swift
//  FosterApp
//
//  Created by Elora on 22/05/2023.
//

import Foundation
import NetworkUtilsKit

/// `APIRequest` conforms to `RequestProtocol` and defines the specifics of a network request to fetch advices.
/// This request is configured to retrieve data from a specific GitHub repository.
struct APIRequest: RequestProtocol {
	/// The scheme of the URL (e.g., "https").
    var scheme: String {"https"}
    
	/// The host domain for the request (e.g., GitHub domain).
    var host: String { "raw.githubusercontent.com" }

	/// The path to the specific resource in the GitHub repository.
	/// This path points to the `Advices.json` file in the specified repository and branch.
    var path: String { "/Elora-Kittink/EloraDelpierre_12_23022023/develop/FosterApp/Data/Advices/Advices.json" }
    
	/// The HTTP method used for the request (in this case, a GET request).
    var method: NetworkUtilsKit.RequestMethod { .get }
}
