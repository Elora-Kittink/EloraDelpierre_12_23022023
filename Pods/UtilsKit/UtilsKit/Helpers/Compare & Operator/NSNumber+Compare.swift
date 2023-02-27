//
//  NSNumber+Compare.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

extension NSNumber: Comparable {
    
    // MARK: Double Value
    /**
     Compare two `NSNumber`
     
     - parameter lhs: left member number
     
     - parameter rhs: right member number
     
     - returns: a `boolean` value indicating if the left member is less than the right member.
     */
    public static func < (lhs: NSNumber, rhs: NSNumber) -> Bool {
        lhs.doubleValue < rhs.doubleValue
    }
    
    /**
     Compare two `NSNumber`
     
     - parameter lhs: left member number
     
     - parameter rhs: right member number
     
     - returns: a `boolean` value indicating if the left member is bigger than the right member.
     */
    public static func > (lhs: NSNumber, rhs: NSNumber) -> Bool {
        lhs.doubleValue > rhs.doubleValue
    }
    
    /**
     Compare two `NSNumber`
     
     - parameter lhs: left member number
     
     - parameter rhs: right member number
     
     - returns: a `boolean` value indicating if the numbers are equals.
     */
    public static func == (lhs: NSNumber, rhs: NSNumber) -> Bool {
        lhs.doubleValue == rhs.doubleValue
    }
}
