//
//  UIImage+TintColorable.swift
//  UtilsKit
//
//  Created by RGMC on 05/04/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /**
     Set the image colorated with given color.
     
     - parameter image: image
     - parameter color: color of the image
     */
    public func setImage(_ image: UIImage, withColor color: UIColor) {
        self.image = image.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
    
    /**
     Set the image colorated with given color.
     
     - parameter color: color of the image
     */
    public func setImageColor(_ color: UIColor) {
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}
