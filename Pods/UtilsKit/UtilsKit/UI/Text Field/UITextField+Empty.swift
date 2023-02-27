//
//  UITextField+Empty.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 17/01/2022.
//  Copyright © 2022 RGMC. All rights reserved.
//

import UIKit

extension UITextField {
	
	/**
	 Check if text is nil or empty
	 */
	public var isEmpty: Bool {
		self.text?.isEmpty ?? true
	}
}
