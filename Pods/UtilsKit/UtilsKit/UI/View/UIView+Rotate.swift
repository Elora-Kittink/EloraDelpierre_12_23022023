//
//  UIView+Rotate.swift
//  UtilsKit
//
//  Created by RGMC on 07/03/2019.
//  Copyright © 2019 RGMC. All rights reserved.
//

import UIKit

extension UIView {
    
    private static let kRotationAnimationKey: String = "rotationanimationkey"
    
    /**
     Start 360 degree rotation on view
     
     - parameter duration: the duration of the animation
     */
    public func rotate(duration: Double = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            rotationAnimation.isRemovedOnCompletion = false
            
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
    
    /**
     Stop rotation animation on view started with `rotate(duration:)`
     */
    public func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
}
