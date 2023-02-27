//
//  String+Validate.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

extension String {
    
    /**
     Check if the string is a valid email format.
     
     - returns: a boolean indicating if the string in a valid email format.
     */
    public var isValidEmail: Bool {
        let regex: String = "^.+@.+\\..+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
}
