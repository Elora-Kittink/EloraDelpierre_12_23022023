//
//  String+Dictionnary.swift
//  UtilsKit
//
//  Created by RGMC on 04/04/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

extension String {
    
    /**
     Transorm a JSON like string into a dictionnary.
     
     - returns: a dictionnary representing the JSON string or nil if failure.
     */
    public func toDictionnary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                log(.data, "\(self) to Dictionnary", error: error)
            }
        }
        return nil
    }
    
    /**
     Transorm a JSON like string into an array of dictionnary.
     
     - returns: an array dictionnary representing the JSON string or nil if failure.
     */
    public func toArrayDictionnary() -> [[String: Any]]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            } catch {
                log(.data, "\(self) to Array Dictionnary", error: error)
            }
        }
        return nil
    }
}
