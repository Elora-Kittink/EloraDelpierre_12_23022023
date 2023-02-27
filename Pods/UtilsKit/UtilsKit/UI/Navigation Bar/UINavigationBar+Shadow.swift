//
//  UINavigationBar+Shadow.swift
//  UtilsKit
//
//  Created by RGMC on 10/07/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    /**
     Remove navigation bar shadow
     */
    public func removeShadow() {
        self.shadowImage = UIImage()
        if #available(iOS 11, *) { } else {
            self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        }
    }
    
    /**
     Add navigation bar shadow
     */
    public func addShadow() {
        self.shadowImage = nil
        if #available(iOS 11, *) { } else {
            self.setBackgroundImage(nil, for: UIBarMetrics.default)
        }
    }
}
