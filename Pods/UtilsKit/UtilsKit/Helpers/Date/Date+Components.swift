//
//  Date+Components.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 17/01/2022.
//  Copyright © 2022 RGMC. All rights reserved.
//

import Foundation

extension Date {
	
	/**
	 Transforme Date to same date with only components
	 */
	public func toDate(with components: Set<Calendar.Component>) -> Date {
		Calendar.current.date(from: Calendar.current.dateComponents(components, from: self)) ?? self
	}
}
