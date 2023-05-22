//
//  APIRequest.swift
//  FosterApp
//
//  Created by Elora on 22/05/2023.
//

import Foundation
import NetworkUtilsKit

struct APIRequest: RequestProtocol, MockProtocol {
    
    var scheme: String {"https"}
    
    var host: String { "raw.githubusercontent.com" }
    
    var path: String { "/Elora-Kittink/EloraDelpierre_12_23022023/b2755a2694404076afc6c0956fa6fb6b24be2b6e/FosterApp/Data/Advices/Advices.json" }
    
    var method: NetworkUtilsKit.RequestMethod { .get }
    
    var mockFileURL: URL? {
        guard let path = Bundle.main.path(forResource: ProcessInfo.processInfo.environment["mockRecipeResponse"],
                                          ofType: "json")
        else { return nil }
        let url = URL(fileURLWithPath: path)

        return url
    }
}
//https://raw.githubusercontent.com/Elora-Kittink/EloraDelpierre_12_23022023/b2755a2694404076afc6c0956fa6fb6b24be2b6e/FosterApp/Data/Advices/Advices.json

