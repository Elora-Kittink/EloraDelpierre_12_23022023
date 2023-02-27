//
//  UITextField+Placeholder.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

extension UITextField {
    
    /**
     Set the color of the placeholder.
     
     - parameter color: the color of the placeholder.
     */
    public func setPlaceholderColor(_ color: UIColor) {
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}
