//
//  UINavigationController+NavigationBar.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

extension UINavigationController {
	
	/**
	Clear the navigation bar background, navigation bar is present but transparent
	*/
	public func setNavigationBarTransparent(_ value: Bool) {
		if value {
			self.navigationBar.removeShadow()
			self.navigationBar.isTranslucent = true
			self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		} else {
			self.navigationBar.addShadow()
			self.navigationBar.isTranslucent = false
			self.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
		}
		
		self.isNavigationBarHidden = false
	}
}
