//
//  URL+Parameters.swift
//  UtilsKit
//
//  Created by RGMC on 10/01/2019.
//  Copyright © 2019 RGMC. All rights reserved.
//

import Foundation

extension URL {
    
    /**
     Get the URL query parameters.
     
     - returns: the query parameters.
     */
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems
        else {
            return nil
        }
        
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        
        return parameters
    }
}
