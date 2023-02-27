//
//  UIScrollView+Keyboard.swift
//  UtilsKit
//
//  Created by RGMC on 29/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

@available(iOSApplicationExtension, introduced: 1.0, unavailable)
extension UIScrollView {
    
    /**
     Scroll scroll view when keyboard appears.
     
     - parameter value: either add or remove observers received on keyboard appearance. Default value is `true` which adds obervers.
     */
    public func scrollWithKeyboard(_ value: Bool = true) {
        if value {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardAction),
                                                   name: UIResponder.keyboardWillShowNotification,
                                                   object: nil)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardAction),
                                                   name: UIResponder.keyboardWillHideNotification,
                                                   object: nil)
        } else {
            NotificationCenter.default.removeObserver(self,
                                                      name: UIResponder.keyboardWillShowNotification,
                                                      object: nil)
            NotificationCenter.default.removeObserver(self,
                                                      name: UIResponder.keyboardWillHideNotification,
                                                      object: nil)
        }
    }
    
    @objc
	private func keyboardAction(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let superview = self.superview else { return }
        
        let keyboardViewEndFrame: CGRect = superview.convert(keyboardScreenEndFrame, from: superview.window)
        
        // Open or close
        if #available(iOS 11.0, *) {
            if notification.name == UIResponder.keyboardWillHideNotification {
                self.contentInset = UIEdgeInsets.zero
            } else {
                self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height + 30, right: 0)
            }
        } else {
            let top: CGFloat = UIApplication.shared.topViewController?.navigationController?.isNavigationBarHidden ?? true ?
                0 :
                UIApplication.shared.topViewController?.navigationController?.navigationBar.frame.size.height ?? 0
            
            if notification.name == UIResponder.keyboardWillHideNotification {
                self.contentInset = UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
            } else {
                self.contentInset = UIEdgeInsets(top: top, left: 0, bottom: keyboardViewEndFrame.height + 30, right: 0)
            }
        }
        
        self.scrollIndicatorInsets = self.contentInset
    }
}
