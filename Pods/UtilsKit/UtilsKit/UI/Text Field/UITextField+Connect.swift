//
//  UITextField+Connect.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 01/09/2021.
//  Copyright © 2021 RGMC. All rights reserved.
//

import UIKit

extension UITextField {
	
	/// Connect next textfield button
	public static func connectTextFields(_ textFields: UITextField...,
										 withFinalReturnKey returnKeyType: UIReturnKeyType = .go) {
		if let last = textFields.last { last.returnKeyType = returnKeyType }
		
		for item in 0 ..< textFields.count - 1 {
			textFields[item].returnKeyType = .next
			textFields[item].addTarget(
				textFields[item + 1],
				action: #selector(UIResponder.becomeFirstResponder),
				for: .editingDidEndOnExit)
		}
	}
}
