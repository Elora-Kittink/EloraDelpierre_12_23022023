//
//  UITabBarController+Item.swift
//  UtilsKit
//
//  Created by RGMC on 26/11/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

extension UITabBarController {
    
    /**
     Get the item at inde.
     
     - returns: the item if exist else nil.
     */
    public func getItem(at index: Int) -> UIView? {
        var currentIndex: Int = 0
        
        for view in self.tabBar.subviews where view is UIControl {
            if currentIndex == index { return view }
            currentIndex += 1
        }
        return nil
    }
}
