//
//  UIView+ViewController.swift
//  UtilsKit
//
//  Created by RGMC on 21/11/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     Get the view controller who contrains the view
     
     - returns: the view controller if exist.
     */
    public var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        
        while let parent: UIResponder = parentResponder {
            parentResponder = parent.next
            if let viewController: UIViewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
