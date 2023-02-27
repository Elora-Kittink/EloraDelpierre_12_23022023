//
//  UIView+Gradient.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation
import UIKit

@available(iOSApplicationExtension, introduced: 1.0, unavailable)
extension UIView {
    
    /// Gradient direction case
    public enum GradientDirection {
        /// Horizontal gradient
        case horizontal
        
        /// Vertical gradient
        case vertical
    }
    
    /**
     Add a gradient effect to the view.
     
     - parameter colors: an array of the colors of the gradient.
     
     - returns: the layer representing the gradient
     */
    @discardableResult
	public func addGradient(_ colors: [UIColor], direction: GradientDirection) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        var frame = self.bounds
        if self is UINavigationBar { frame.size.height += UIApplication.shared.statusBarFrame.height }
        gradient.frame = frame
        gradient.colors = colors.map { $0.cgColor }
        
        switch direction {
        case .horizontal:
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 0)
            
        case .vertical:
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 0, y: 1)
        }
        
        if let tabBar = self as? UITabBar {
            tabBar.isTranslucent = true
            tabBar.backgroundColor = .clear
            tabBar.backgroundImage = UIImage()
        }
        
        if let navigationBar = self as? UINavigationBar {
            var image: UIImage?
            
            UIGraphicsBeginImageContext(gradient.bounds.size)
            if let context = UIGraphicsGetCurrentContext() {
                gradient.render(in: context)
                image = UIGraphicsGetImageFromCurrentImageContext()
            }
            UIGraphicsEndImageContext()
            
            navigationBar.setBackgroundImage(image, for: .default)
        } else {
            self.layer.insertSublayer(gradient, at: 0)
        }
        
        return gradient
    }
}
