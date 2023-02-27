//
//  UIButton+TintColorable.swift
//  UtilsKit
//
//  Created by RGMC on 12/05/2020.
//  Copyright © 2020 RGMC. All rights reserved.
//

import UIKit

extension UIButton {
    
    /**
        Set the image colorated with given color.
     
        - parameter image: image
        - parameter color: color of the image
     */
    public func setImage(_ image: UIImage, withColor color: UIColor, for state: UIControl.State) {
        self.setImage(image.withRenderingMode(.alwaysTemplate), for: state)
        
        switch buttonType {
        case .custom: self.imageView?.tintColor = color
        default: self.tintColor = color
        }
    }
    
    /**
        Set the image colorated with given color.
     
        - parameter color: color of the image
     */
    public func setImageColor(_ color: UIColor, for state: UIControl.State) {
        guard let image = self.image(for: state) else { return }
        self.setImage(image.withRenderingMode(.alwaysTemplate), for: state)
        
        switch buttonType {
        case .custom: self.imageView?.tintColor = color
        default: self.tintColor = color
        }
    }
}
