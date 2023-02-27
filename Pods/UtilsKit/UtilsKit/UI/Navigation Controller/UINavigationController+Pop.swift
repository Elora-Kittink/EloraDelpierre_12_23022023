//
//  UINavigationController+Pop.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 17/01/2022.
//  Copyright © 2022 RGMC. All rights reserved.
//

import UIKit

extension UINavigationController {
	
	/**
	 Pop controller until find one if type `type`
	 */
	public func popToViewControllerType<T: UIViewController>(_ type: T.Type, animated: Bool) {
		guard let viewController = self
				.viewControllers
				.first(where: { $0 is T })
		else { return }
		
		self.popToViewController(viewController,
								 animated: animated)
	}
}
