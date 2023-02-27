//
//  Date+String.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

extension Date {
    
    /**
    Transform a data into a string.
    
    - parameter format: the format to convert the date from. The default format is `dd/MM/yyyy`
    
    - returns: the date converted into a string with specified format.
    */
    public func toString(format: String = "dd/MM/yyyy",
                         locale: Locale = Locale.current) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension String {
    
    /**
        Transform a string into a date.
     
        - parameter format: the format to convert the string from. The default format is `yyyy-MM-dd'T'HH:mm:ssZ`
     
        - returns: the string converted into a date with specified format.
     */
    public func toDate(format: String = "yyyy-MM-dd'T'HH:mm:ssZ",
                       locale: Locale = Locale.current) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}
