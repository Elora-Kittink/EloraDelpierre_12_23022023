//
//  NSLayoutConstraint+Multiplier.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 26/05/2021.
//  Copyright © 2021 RGMC. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
	
	/**
	Set constraint multiplier
	
	- parameter multiplier: multiplier
	- returns: new constraint
	
	*/
	public func setMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {
		
		NSLayoutConstraint.deactivate([self])
		
		let newConstraint = NSLayoutConstraint(
			item: firstItem as Any,
			attribute: firstAttribute,
			relatedBy: relation,
			toItem: secondItem,
			attribute: secondAttribute,
			multiplier: multiplier,
			constant: constant)
		
		newConstraint.priority = priority
		newConstraint.shouldBeArchived = self.shouldBeArchived
		newConstraint.identifier = self.identifier
		
		NSLayoutConstraint.activate([newConstraint])
		return newConstraint
	}
}
