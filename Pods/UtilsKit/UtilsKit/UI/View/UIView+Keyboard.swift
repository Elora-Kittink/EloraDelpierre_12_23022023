//
//  UIView+Keyboard.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

private class HideKeyboardTapGesture: UITapGestureRecognizer { }

extension UIView: UIGestureRecognizerDelegate {
    
    /**
     Default implementation of the delegate method to not override gestures or actions in view when `hideKeyboardOnTap` is used.
     */
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if
            gestureRecognizer is HideKeyboardTapGesture &&
                (touch.view is UIControl || (touch.view?.gestureRecognizers?.contains(where: { !($0 is HideKeyboardTapGesture) }) ?? false)) {
            return false
        }
        return true
    }
    
    /**
     Close keyboard when tap on this view
     */
    public func hideKeyboardOnTap() {
        let tapGesture = HideKeyboardTapGesture(target: self, action: #selector(self.endEditing(_:)))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        self.addGestureRecognizer(tapGesture)
        
        if let scrollView = self as? UIScrollView, scrollView.keyboardDismissMode == .none {
            scrollView.keyboardDismissMode = .onDrag
        }
    }
}
