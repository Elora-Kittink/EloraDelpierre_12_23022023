//
//  UIApplication+TopViewController.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

@available(iOSApplicationExtension, introduced: 1.0, unavailable)
extension UIApplication {
    
    /**
     The current view controller if exists.
     */
    public var topViewController: UIViewController? {
        self.topViewController()
    }
    
    /**
     The current alert view controller if exists.
     */
    public var topAlertView: UIAlertController? {
        topViewController as? UIAlertController
    }
    
    private func topViewController(_ baseViewController: UIViewController? = nil) -> UIViewController? {
        
        let currentBaseViewController: UIViewController?
            
        if let baseVC: UIViewController = baseViewController {
            currentBaseViewController = baseVC
        } else if #available(iOS 13.0, *),
                  let sceneDelegate: UIWindowSceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? UIWindowSceneDelegate,
                  let rootVC: UIViewController = sceneDelegate.window??.rootViewController {
            currentBaseViewController = rootVC
        } else {
            currentBaseViewController = UIApplication.shared.delegate?.window??.rootViewController
        }

            
        if let nav: UINavigationController = currentBaseViewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab: UITabBarController = currentBaseViewController as? UITabBarController {
            if let selected: UIViewController = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented: UIViewController = currentBaseViewController?.presentedViewController {
            return topViewController(presented)
        }
        
        if let searchViewController: UISearchController = currentBaseViewController as? UISearchController {
            return searchViewController.presentingViewController ?? currentBaseViewController
        }
        
        return currentBaseViewController
    }
}
