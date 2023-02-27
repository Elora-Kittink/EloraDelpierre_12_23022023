//
//  NavigationError.swift
//  UtilsKit
//
//  Created by RGMC on 15/06/2020.
//  Copyright © 2020 RGMC. All rights reserved.
//

import Foundation

public enum NavigationError: Error, LocalizedError {
    case pushWithoutNavigationController
    case pushOnAlertController
    
    public var errorDescription: String? {
        switch self {
        case .pushWithoutNavigationController: return "Attempt to push a controller without UINavigationController"
        case .pushOnAlertController: return "Attempt to push a controller on a UIAlertController"
        }
    }
}
