//
//  Date+Days.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 17/01/2022.
//  Copyright © 2022 RGMC. All rights reserved.
//

import Foundation

extension Date {
	
	/**
	 Returns day between 2 dates
	 */
	public static func daysBetween(date date1: Date, and date2: Date) -> Int {
		abs(Calendar.current.dateComponents([.day],
											from: date1,
											to: date2)
				.day ?? 0)
	}
}
