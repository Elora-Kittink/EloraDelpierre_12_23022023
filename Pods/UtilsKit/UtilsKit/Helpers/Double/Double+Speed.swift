//
//  Double+Speed.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 26/05/2021.
//  Copyright © 2021 RGMC. All rights reserved.
//

import Foundation

extension Double {

	/**
	Self in speed from kilometers per hour
	
	- parameter locale : Locale. Default current
	- returns: self in speed.
	
	~~~
	let value = 1
	print(value.toSpeed()) // prints `1 km/h` in France, `0,6 mile/h` in US
	~~~
	*/
	public func toSpeed(maximumFractionDigits: Int = 1,
						locale: Locale = .current) -> String {
		let value = NSMeasurement(doubleValue: self, unit: UnitSpeed.kilometersPerHour)
		let formatter = MeasurementFormatter()
		formatter.numberFormatter.maximumFractionDigits = maximumFractionDigits
		formatter.locale = locale
		return formatter.string(from: value as Measurement<Unit>)
	}
}

extension Int {
	
	/**
	Self in speed from kilometers per hour
	
	- parameter locale : Locale. Default current
	- returns: self in speed.
	
	~~~
	let value = 1
	print(value.toSpeed()) // prints `1 km/h` in France, `0,6 mile/h` in US
	~~~
	*/
	public func toSpeed(maximumFractionDigits: Int = 1,
						locale: Locale = .current) -> String {
		Double(self).toSpeed(maximumFractionDigits: maximumFractionDigits, locale: locale)
	}
}
