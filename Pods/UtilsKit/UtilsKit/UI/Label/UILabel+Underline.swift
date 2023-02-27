//
//  UILabel+Underline.swift
//  UtilsKit
//
//  Created by RGMC on 02/09/2019.
//  Copyright © 2019 RGMC. All rights reserved.
//

import UIKit

extension UILabel {
    
    /**
     Underline label
     */
    public func underline() {
        guard let text = self.text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: text.count))
        
        self.attributedText = attributedString
    }
}
