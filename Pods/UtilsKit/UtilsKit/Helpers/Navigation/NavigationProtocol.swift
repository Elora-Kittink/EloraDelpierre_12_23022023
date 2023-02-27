//
//  NavigationProtocol.swift
//  UtilsKit
//
//  Created by RGMC on 05/04/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation
import UIKit

/**
 This protocol provides a useful navigation stack management.
 */
@available(iOSApplicationExtension, introduced: 1.0, unavailable)
public protocol NavigationProtocol {
    
    /**
     Kind of segue for the view controller animation.
     */
    var navigationSegue: Segue { get set }
    
    /**
     Instance Identifier
     */
    var instanceIdentifier: String? { get }
    
    /**
     Sender
     */
    var previousViewController: UIViewController? { get set }
}

@available(iOSApplicationExtension, introduced: 1.0, unavailable)
extension NavigationProtocol where Self: UIViewController {
    
    /**
     
     Push the view controller on top of the navigation stack or specific controller.
     
     - parameter controller: controller to push the view controller on top of. Default is nil.
     
     - parameter animated: animate or not. Default is true.
     
     - parameter completion: completion handler called upon push. Default is nil.
     
     */
    public func push(from controller: UIViewController? = nil,
                     animated: Bool = true,
                     completion: (() -> Void)? = nil) {
        
        Segue.push.present(self,
                           from: controller,
                           animated: animated,
                           completion: completion)
    }
    
    /**
     
     Push the view controller on detail side on the current split view contoller or specific controller.
     
     - parameter controller: controller to push the view controller on on detail side. Default is nil.
     
     - parameter withNavigationController: add a UINavigationController or not. Default is false.
     
     - parameter animated: animate or not. Default is true.
     
     - parameter completion: completion handler called upon push. Default is nil.
     
     */
    public func popover(from controller: UIViewController? = nil,
                        withNavigationController: Bool = false,
                        animated: Bool = true,
                        completion: (() -> Void)? = nil) {
        
        Segue.popover.present(self,
                              from: controller,
                              withNavigationController: withNavigationController,
                              animated: animated,
                              completion: completion)
    }
    
    /**
     
     Push the view controller on detail side on the current split view contoller or specific controller.
     
     - parameter controller: controller to push the view controller on on detail side. Default is nil.
     
     - parameter anchor: view to anchor the view controller.
     
     - parameter withNavigationController: add a UINavigationController or not. Default is false.
     
     - parameter animated: animate or not. Default is true.
     
     - parameter completion: completion handler called upon push. Default is nil.
     
     */
    public func popover(anchor: UIView,
                        from controller: UIViewController? = nil,
                        withNavigationController: Bool = false,
                        animated: Bool = true,
                        completion: (() -> Void)? = nil) {
        
        Segue.popoverView(anchor).present(self,
                                          from: controller,
                                          withNavigationController: withNavigationController,
                                          animated: animated,
                                          completion: completion)
    }
    
    
    /**
     
     Push the view controller on detail side on the current split view contoller or specific controller.
     
     - parameter controller: controller to push the view controller on on detail side. Default is nil.
     
     - parameter anchor: UIBarButtonItem to anchor the view controller.
     
     - parameter withNavigationController: add a UINavigationController or not. Default is false.
     
     - parameter animated: animate or not. Default is true.
     
     - parameter completion: completion handler called upon push. Default is nil.
     
     */
    public func popover(anchor: UIBarButtonItem,
                        from controller: UIViewController? = nil,
                        withNavigationController: Bool = false,
                        animated: Bool = true,
                        completion: (() -> Void)? = nil) {
        
        Segue.popoverBarButton(anchor).present(self,
                                               from: controller,
                                               withNavigationController: withNavigationController,
                                               animated: animated,
                                               completion: completion)
    }
    
    /**
     
     Present the view controller on top of the navigation stack or specific controller.
     
     - parameter controller: controller to present the view controller on top of. Default is nil.
     
     - parameter withNavigationController: present the view controller embeded in a navigation controller. Default is false.
     
     - parameter animated: animate or not. Default is true.
     
     - parameter completion: completion handler called upon push. Default is nil.
     
     */
    public func modal(from controller: UIViewController? = nil,
                      withNavigationController: Bool = false,
                      animated: Bool = true,
                      completion: (() -> Void)? = nil) {
        
        Segue.modal.present(self,
                            from: controller,
                            withNavigationController: withNavigationController,
                            animated: animated,
                            completion: completion)
    }
    
    /**
     
     Present the view controller on top of the navigation stack or specific controller with blur effect.
     
     - parameter controller: controller to present the view controller on top of. Default is nil.
     
     - parameter animated: animate or not. Default is true.
     
     - parameter completion: completion handler called upon push. Default is nil.
     
     */
    public func modalBlur(from controller: UIViewController? = nil,
                          animated: Bool = true,
                          completion: (() -> Void)? = nil) {
        
        Segue.modalBlur.present(self,
                                from: controller,
                                animated: animated,
                                completion: completion)
    }
    
    /**
     
     Close the view controller.
     
     - parameter completion: completion handler called upon push.
     
     */
    public func close(_ completion: (() -> Void)? = nil, animated: Bool = true) {
        self.navigationSegue.close(self, animated: animated) {
            completion?()
        }
    }
}

extension UIViewController {
    
    fileprivate func getFirstNavigationController() -> UINavigationController? {
        if let navigationController = self.navigationController {
            return navigationController.getFirstNavigationController()
        }
        return self as? UINavigationController
    }
}
