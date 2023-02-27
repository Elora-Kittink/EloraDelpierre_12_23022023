//
//  UIView+Localize.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

extension UIView {
    /**
     Localize the view
     */
    @objc
	open func localize() {
        self.subviews.forEach { $0.localize() }
    }
}

extension UITextField {
    /**
     Localize the text field
     */
    override open func localize() {
        if let text: String = placeholder {
            self.placeholder = text.localized
        }
        if let text: String = text {
            self.text = text.localized
        }
        if let view = self.rightView {
            view.localize()
        }
        if let view = self.leftView {
            view.localize()
        }
    }
}

extension UIButton {
    /**
     Localize the button
     */
    override open func localize() {
        if let text: String = title(for: UIControl.State()) {
            self.setTitle(text.localized, for: UIControl.State())
        }
    }
}

extension UITextView {
    /**
     Localize the text view
     */
    override open func localize() {
        if let text: String = text {
            self.text = text.localized
        }
    }
}

extension UIStackView {
    /**
     Localize the stack view
     */
    override open func localize() {
        for view in self.arrangedSubviews {
            view.localize()
        }
    }
}

extension UILabel {
    /**
     Localize the label
     */
    override open func localize() {
        self.text = self.text?.localized
    }
}
