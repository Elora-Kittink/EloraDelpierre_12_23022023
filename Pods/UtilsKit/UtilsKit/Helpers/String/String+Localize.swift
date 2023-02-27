//
//  String+Localize.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

extension String {
    
    /**
     Localize the string.
     
     - returns: a localized string.
     */
    public var localized: String {
		NSLocalizedString(self, comment: "")
    }
    
    /**
     Localize the string.
     
     - returns: a localized string or nil.
     */
    public var localizedOrNil: String? { (localized != self ? localized : nil) }
}
