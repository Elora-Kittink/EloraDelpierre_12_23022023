//
//  Array+RemoveDuplicates.swift
//  
//
//  Created by Michael Coqueret on 03/01/2020.
//

import Foundation

extension Array where Element: Equatable {

    /// Return array without duplicate
    public func removeDuplicates() -> [Element] {
        var result = [Element]()

		for value in self where !result.contains(value) {
			result.append(value)
        }

        return result
    }
}
