//
//  String+Ranges.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 27/04/2021.
//  Copyright © 2021 RGMC. All rights reserved.
//

import Foundation

extension String {
	
	/**
	Return all ranges for `substring`
	*/
	public func ranges(of substring: String,
				options: CompareOptions = [],
				locale: Locale? = nil) -> [Range<Index>] {
		
		var ranges: [Range<Index>] = []
		
		while let range = range(of: substring,
								options: options,
								range: (ranges.last?.upperBound ?? self.startIndex)..<self.endIndex,
								locale: locale) {
			ranges.append(range)
		}
		
		return ranges
	}
}
