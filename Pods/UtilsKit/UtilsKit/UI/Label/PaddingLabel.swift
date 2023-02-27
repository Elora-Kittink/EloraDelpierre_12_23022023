//
//  PaddingLabel.swift
//  UtilsKit
//
//  Created by RGMC on 09/11/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

/**
 Label with padding configurable from storyboard
 */
@available(iOSApplicationExtension, introduced: 1.0, unavailable)
@IBDesignable open class PaddingLabel: UILabel {
    
    // MARK: - Inspectables
    @IBInspectable public var topInset: CGFloat = 0.0
    @IBInspectable public var bottomInset: CGFloat = 0.0
    @IBInspectable public var leadingInset: CGFloat = 0.0
    @IBInspectable public var traillingInset: CGFloat = 0.0
    
    // MARK: - Variables
    override open var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize: CGSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += self.topInset + self.bottomInset
        intrinsicSuperViewContentSize.width += self.leadingInset + self.traillingInset
        return intrinsicSuperViewContentSize
    }
    
    private var isRightToLeft: Bool {
        UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
    
    private var insets: UIEdgeInsets {
        let leftInset: CGFloat
        let rightInset: CGFloat
        
        if self.isRightToLeft {
            leftInset = self.traillingInset
            rightInset = self.leadingInset
        } else {
            leftInset = self.leadingInset
            rightInset = self.traillingInset
        }
        
        return UIEdgeInsets(top: self.topInset, left: leftInset, bottom: self.bottomInset, right: rightInset)
    }
    
    // MARK: - Draw
    override open func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: self.insets))
    }
    
    override open func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        super.textRect(forBounds: bounds.inset(by: self.insets), limitedToNumberOfLines: numberOfLines)
    }
}
