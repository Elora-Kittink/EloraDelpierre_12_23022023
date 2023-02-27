//
//  Double+Duration.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 03/09/2020.
//  Copyright © 2020 RGMC. All rights reserved.
//

import Foundation

extension Double {
	
	/**
	 Self in duration.
	 
	 - returns: self in duration.
	 */
	public func toDuration(allowedUnits: NSCalendar.Unit = [
		.year,
		.month,
		.day,
		.hour,
		.minute,
		.second
	],
						   unitStyle: DateComponentsFormatter.UnitsStyle = .full) -> String {
		
		let formatter = DateComponentsFormatter()
		formatter.allowedUnits = allowedUnits
		formatter.unitsStyle = unitStyle
		
		return formatter.string(from: TimeInterval(self)) ?? ""
	}
}

extension Int {
	
	/**
	 Self in duration.
	 
	 - returns: self in duration.
	 */
	public func toDuration(allowedUnits: NSCalendar.Unit = [
		.year,
		.month,
		.day,
		.hour,
		.minute,
		.second
	],
						   unitStyle: DateComponentsFormatter.UnitsStyle = .full) -> String {
		Double(self).toDuration(allowedUnits: allowedUnits, unitStyle: unitStyle)
	}
}
