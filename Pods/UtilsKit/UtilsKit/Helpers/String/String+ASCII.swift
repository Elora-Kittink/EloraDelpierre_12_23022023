//
//  String+ASCII.swift
//  UtilsKit
//
//  Created by RGMC on 27/07/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

extension String {
    
    /// ASCII value
    public var asciiValue: String? {
        do {
            let pattern: String = "(0x)?([0-9a-f]{2})"
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let nsString = self as NSString
            let matches: [NSTextCheckingResult] = regex.matches(in: self, options: [], range: NSRange(location: 0, length: nsString.length))
            
            let characters: [Character] = matches.compactMap {
                guard let value = UInt32(nsString.substring(with: $0.range(at: 2)), radix: 16) else { return nil }
                return UnicodeScalar(value)
            }
            .filter { NSCharacterSet.alphanumerics.contains($0) }
            .map { Character($0) }
            
            return String(characters)
        } catch {
            log(.data, "ASCII value from \(self)", error: error)
            return nil
        }
    }
}
