//
//  APIRequest.swift
//  FosterApp
//
//  Created by Elora on 22/05/2023.
//

import Foundation
import NetworkUtilsKit

struct APIRequest: RequestProtocol {
    
    var scheme: String {"https"}
    
    var host: String { "raw.githubusercontent.com" }

    var path: String { "/Elora-Kittink/EloraDelpierre_12_23022023/develop/FosterApp/Data/Advices/Advices.json" }
    
    var method: NetworkUtilsKit.RequestMethod { .get }
}
