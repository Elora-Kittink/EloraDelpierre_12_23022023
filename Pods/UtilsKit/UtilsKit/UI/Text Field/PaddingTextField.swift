//
//  PaddingTextField.swift
//  UtilsKit
//
//  Created by RGMC on 09/11/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

/**
 Textfield with padding configurable from storyboard
 */
@IBDesignable open class PaddingTextField: UITextField {
    
    @IBInspectable open var topInset: CGFloat = 0.0
    @IBInspectable open var bottomInset: CGFloat = 0.0
    @IBInspectable open var leftInset: CGFloat = 0.0
    @IBInspectable open var rightInset: CGFloat = 0.0
    
    private var padding: UIEdgeInsets {
        UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}
