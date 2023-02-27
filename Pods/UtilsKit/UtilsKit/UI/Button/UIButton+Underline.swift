//
//  UIButton+Underline.swift
//  UtilsKit
//
//  Created by RGMC on 10/12/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

extension UIButton {
    
    /**
     Underline button
     */
    public func underline() {
        guard let text = self.titleLabel?.text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: text.count))
        
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
