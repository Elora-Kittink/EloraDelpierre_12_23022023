//
//  NSLocale+Localize.swift
//  UtilsKit
//
//  Created by RGMC on 08/06/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

extension NSLocale {
    
    /**
     The current language.
     
     - returns: the current language.
     */
    public static var currentLanguage: String? {
        get {
            if let currentLanguage = UserDefaults.standard.string(forKey: "AppleLanguages") {
                return currentLanguage
            } else {
                return NSLocale.preferredLanguages.first
            }
        }
        set {
            UserDefaults.standard.set([newValue], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name.languageDidChange, object: nil)
        }
    }
}

extension Notification.Name {
    
    /// Notification when NSLocale.currentLanguage did change
    public static let languageDidChange = Notification.Name("KLanguageDidChange")
}
