//
//  UIView+Blur.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     Add blur effect to the view.
     
     - parameter style: the style of the blur effect. Default is .dark.
     
     - returns: the blur effet view.
     */
    @discardableResult
	public func addBlur(_ style: UIBlurEffect.Style = .dark) -> UIVisualEffectView? {
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.backgroundColor = UIColor.clear
            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.insertSubview(blurEffectView, at: 0)
            return blurEffectView
        } else {
            switch style {
            case .dark: self.backgroundColor = UIColor.black
            default: self.backgroundColor = UIColor.white
            }
        }
        return nil
    }
}
