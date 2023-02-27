//
//  UIStackView+Empty.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 17/01/2022.
//  Copyright © 2022 RGMC. All rights reserved.
//

import UIKit

extension UIStackView {
	
	/**
	 Remove all view who satisfy filters
	 */
	public func removeAll(where filter: ((UIView) -> Bool)? = nil) {
		self.arrangedSubviews.forEach {
			if filter?($0) ?? true {
				self.removeArrangedSubview($0)
				$0.removeFromSuperview()
			}
		}
	}
}
