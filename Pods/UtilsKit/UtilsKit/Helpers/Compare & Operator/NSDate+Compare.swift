//
//  NSDate+Compare.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

// MARK: NSDate
extension NSDate: Comparable {
    
    /**
     Compare two `NSDate`
     
     - parameter lhs: left member date
     
     - parameter rhs: right member date
     
     - returns: a `boolean` value indicating if the left member is equal to the right member
     */
    public static func == (lhs: NSDate, rhs: NSDate) -> Bool {
        lhs === rhs || lhs.compare(rhs as Date) == .orderedSame
    }
    
    
    /**
     Compare two `NSDate`
     
     - parameter lhs: left member date
     
     - parameter rhs: right member date
     
     - returns: a `boolean` value indicating if the left member is less than to the right member
     */
    public static func < (lhs: NSDate, rhs: NSDate) -> Bool {
        lhs.compare(rhs as Date) == .orderedAscending
    }
    
    /**
     Compare two `NSDate`
     
     - parameter lhs: left member date
     
     - parameter rhs: right member date
     
     - returns: a `boolean` value indicating if the left member is greater than to the right member
     */
    public static func > (lhs: NSDate, rhs: NSDate) -> Bool {
        lhs.compare(rhs as Date) == .orderedDescending
    }
}

extension Optional where Wrapped == Date {
    /**
     Compare two `Date`
     
     - parameter lhs: left member date
     
     - parameter rhs: right member date
     
     - returns: a `boolean` value indicating if the left member is equal to the right member
     */
    public static func == (lhs: Date?, rhs: Date?) -> Bool {
        guard let lhs = lhs, let rhs = rhs else { return false }
        return lhs.compare(rhs) == .orderedSame
    }
    
    /**
     Compare two `Date`
     
     - parameter lhs: left member date
     
     - parameter rhs: right member date
     
     - returns: a `boolean` value indicating if the left member is greater than to the right member
     */
    public static func < (lhs: Date?, rhs: Date?) -> Bool {
        guard let lhs = lhs else { return false }
        guard let rhs = rhs else { return true }
        return lhs.compare(rhs) == .orderedAscending
    }
    
    /**
     Compare two `Date`
     
     - parameter lhs: left member date
     
     - parameter rhs: right member date
     
     - returns: a `boolean` value indicating if the left member is less than to the right member
     */
    public static func > (lhs: Date?, rhs: Date?) -> Bool {
        guard let lhs = lhs else { return false }
        guard let rhs = rhs else { return true }
        return lhs.compare(rhs) == .orderedDescending
    }
}
