//
//  Array+Same.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 17/01/2022.
//  Copyright © 2022 RGMC. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
	
	/// Check if two array has same elements
	public func isSame(array: [Element]) -> Bool {
		self.containsAll(array) && array.containsAll(self)
	}
}
