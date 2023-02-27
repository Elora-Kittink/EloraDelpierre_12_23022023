//
//  Double+Distance.swift
//  UtilsKit
//
//  Created by RGMC on 10/07/2020.
//  Copyright © 2020 RGMC. All rights reserved.
//

import Foundation

extension Double {
	
	/**
	Self in distance with maximum fraction digits from meters to local measurement
	
	- parameter maximumFractionDigits : Maximum fraction digits. Default 1
	- parameter locale : Locale. Default current
	- returns: The formated result

	~~~
	let value = 1000
	print(value.toDistance()) // prints `1 km` in France, `0,6 mile` in US
	~~~
	*/
	public func toDistance(maximumFractionDigits: Int = 1,
						   locale: Locale = Locale.current) -> String {
		let nbFormatter = NumberFormatter()
		nbFormatter.maximumFractionDigits = maximumFractionDigits
		
		let formatter = MeasurementFormatter()
		formatter.locale = locale
		formatter.numberFormatter = nbFormatter
		formatter.unitOptions = .naturalScale
		
		return formatter.string(from: Measurement(value: self, unit: UnitLength.meters))
	}
}

extension Int {
	
	/**
	Self in distance with maximum fraction digits from meters to local measurement
	
	- parameter maximumFractionDigits : Maximum fraction digits. Default 1
	- parameter locale : Locale. Default current
	- returns: The formated result

	~~~
	let value = 1000
	print(value.toDistance()) // prints `1 km` in France, `0,6 mile` in US
	~~~
	*/
	public func toDistance(maximumFractionDigits: Int = 1,
						   locale: Locale = Locale.current) -> String {
		Double(self).toDistance(maximumFractionDigits: maximumFractionDigits, locale: locale)
	}
}
