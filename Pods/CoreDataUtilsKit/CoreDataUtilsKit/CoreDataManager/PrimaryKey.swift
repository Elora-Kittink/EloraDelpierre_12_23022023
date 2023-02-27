//
//  PrimaryKey.swift
//  Hager Data Kit
//
//  Created by RGMC on 17/01/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

/**
 this protocole is used to limit fetches and creation with attribute of type INT or String (nothing else)
 it's like a type Alias for 2 type (string and int)
 */
public protocol PrimaryKey { }

extension String: PrimaryKey { }
extension Int: PrimaryKey { }

extension PrimaryKey {
    
    internal var stringValue: String? {
        var output: String?
        if let value = self as? String { output = value }
        if let value = self as? Int { output = String(value) }
        
        assert(output != nil, "your primary Key must be eather an INT or a STRING")
        return output
    }
    
    internal var intValue: Int? {
        var output: Int?
        if let value = self as? String { output = Int(value) }
        if let value = self as? Int { output = value }
        assert(output != nil, "your primary Key must be eather an INT or a STRING")
        return output
    }
}
