//
//  UIView+CornerRadius.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 17/01/2022.
//  Copyright © 2022 RGMC. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
	
	/**
	 Set corner radius for sprecific edges
	 */
	public func setCornerRadius(_ radius: CGFloat = 12,
								edges: CACornerMask = [
									.layerMaxXMaxYCorner,
									.layerMaxXMinYCorner,
									.layerMinXMaxYCorner,
									.layerMinXMinYCorner
								]) {
									self.layer.masksToBounds = true
									if #available(iOS 13.0, *) {
										self.layer.cornerCurve = .continuous
									}
									self.layer.cornerRadius = radius
									self.layer.maskedCorners = edges
								}
}
