//
//  Array+URLQueryItem.swift
//  UtilsKit
//
//  Created by RGMC on 15/05/2019.
//  Copyright © 2019 RGMC. All rights reserved.
//

import Foundation

extension Array where Iterator.Element == URLQueryItem {
    
    /**
     Transform query item on Dictionary
     */
    public func toDictionary() -> [String: String] {
        var dict: [String: String] = [:]
        
        for item in self {
            dict[item.name] = item.value
        }
        
        return dict
    }
}

extension URL {
    
    /**
     Get the URL query items
     */
    public func getQueryItems() -> [String: String] {
        guard let items = URLComponents(string: self.absoluteString)?.queryItems else { return [:] }
        return items.toDictionary()
    }
}
