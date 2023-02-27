//
//  String+ExtractValueFromRegex.swift
//  UtilsKit
//
//  Created by RGMC on 19/07/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

extension String {
	
	/**
	 Check if self matches regex
	 
	 - parameter regex: the regex
	 */
	public func matches(regex: String) -> Bool {
		self.range(of: regex,
				   options: .regularExpression) != nil
	}
    
    /**
     Search value from regex in self.
     
     - parameter regex: the regex
     - returns: all string who respect the regex
     */
    public func values(forRegex regex: String) -> [String] {
		do {
			let regex = try NSRegularExpression(pattern: regex, options: [])
			let matches = regex.matches(in: self,
										options: [],
										range: NSRange(location: 0,
													   length: self.utf16.count))
			guard let match = matches.first else { return [] }
			var array: [String] = []
			
			for index in 1...match.numberOfRanges - 1 {
				let range = match.range(at: index)
				if let swiftRange = Range(range, in: self) {
					array.append(String(self[swiftRange]))
				}
			}
			return array
		} catch {
			log(.data, "Regex \(regex) in \(self)", error: error)
			return []
		}
    }
}
