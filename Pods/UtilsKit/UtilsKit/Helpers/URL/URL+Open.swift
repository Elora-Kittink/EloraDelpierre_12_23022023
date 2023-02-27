//
//  URL+Open.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import SafariServices
import UIKit

@available(iOSApplicationExtension, introduced: 1.0, unavailable)
extension URL {
    
    /**
     Open the URL.
     
     - parameter inApp: indicate if it is an in-app URL (such as deeplink). Default is true.
     - parameter safariControllerClass: indicate custom safariController class.
     */
    public func open<T: SFSafariViewController>(safariControllerClass: T.Type, inApp: Bool = true) {
        if !self.absoluteString.hasPrefix("http") || !inApp {
            self._open()
            return
        } else {
            guard let currentViewController = UIApplication.shared.topViewController else {
                self._open()
                return
            }
            let safariController: T = safariControllerClass.init(url: self)
            currentViewController.present(safariController, animated: true, completion: nil)
        }
    }
    
    /**
     Open the URL.
     
     - parameter inApp: indicate if it is an in-app URL (such as deeplink). Default is true.
     */
    public func open(inApp: Bool = true) {
        self.open(safariControllerClass: SFSafariViewController.self, inApp: inApp)
    }
    
    private func _open() {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(self, options: [:], completionHandler: nil)
        } else {
            _ = UIApplication.shared.openURL(self)
        }
    }
}
