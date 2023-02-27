//
//  Dictionary+Keys.swift
//  UtilsKit
//
//  Created by RGMC on 27/07/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

extension Dictionary where Key == String {
    
    private enum ObjectError: Error, LocalizedError {
        case notFound(key: String, type: String)
        
        var errorDescription: String? {
            switch self {
            case .notFound(let key, let type):
                return "\(key) not found for type \(type)"
            }
        }
    }
    
    /**
     Get value for multiple keys.
     
     - paremeter key: keys (separated by .)
     - returns: the current language.
     */
    public func getValue<T: Any>(for key: Key) throws -> T {
        var keys: [String] = key.split(separator: ".").map { String($0) }
        
        if let firstKey: String = keys.first, keys.count > 1 {
            if let next: [String: Any] = try? self.getValue(for: firstKey) {
                keys.remove(at: 0)
                return try next.getValue(for: keys.joined(separator: "."))
            }
        }
        
        let value = self[key] as? T
        
        switch value {
        case .none:
            throw ObjectError.notFound(key: key, type: String(describing: T.self))
            
        case .some(let valueNotNil):
            return valueNotNil
        }
    }
}
