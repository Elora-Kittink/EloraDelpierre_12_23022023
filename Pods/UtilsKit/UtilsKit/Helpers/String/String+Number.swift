//
//  String+Number.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 17/01/2022.
//  Copyright © 2022 RGMC. All rights reserved.
//

import Foundation

extension String {
	
	/// Check if self is number
	public var isNumber: Bool {
		!isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
	}
	
	private var value: String {
		self.replacingOccurrences(of: ",", with: ".")
	}
	
	/// Return self as NSNumber
	public var toNumber: NSNumber? {
		guard let value = self.toDouble else { return nil }
		return NSNumber(value: value)
	}
	
	/// Return self as Double
	public var toDouble: Double? {
		Double(self.value)
	}
	
	/// Return self as Float
	public var toFloat: Float? {
		Float(self.value)
	}
	
	/// Return self as Int
	public var toInt: Int? {
		self.toNumber?.intValue
	}
	
	/// Return self as Bool
	public var toBool: Bool? {
		self.toNumber?.boolValue
	}
}
