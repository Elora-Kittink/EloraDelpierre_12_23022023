//
//  IdentifiableObject.swift
//  UtilsKit
//
//  Created by RGMC on 18/10/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

/**
 Make an object identifiable
 */
public protocol IdentifiableObject {
    
    /// Unique identifier
    var identifier: ObjectIdentifier { get }
    
    /// Compare this Identifiable with an other one
    func isEqualTo(_ identifiable: IdentifiableObject) -> Bool
}

extension IdentifiableObject {
    /**
     Check the equality of two identifiables
     */
    public func isEqualTo(_ identifiable: IdentifiableObject) -> Bool {
        self.identifier == identifiable.identifier
    }
}
