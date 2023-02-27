//
//  UIDeviceOrientation+InterfaceOrientation.swift
//  UtilsKit
//
//  Created by RGMC on 26/11/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

extension UIDeviceOrientation {
    /**
     Interface orientation of this device orientation
     */
    public var interfaceOrientation: UIInterfaceOrientation {
        switch self {
        case .unknown, .faceUp, .faceDown: return .unknown
        case .portrait: return .portrait
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeLeft: return .landscapeRight
        case .landscapeRight: return .landscapeLeft
        @unknown default: return .unknown
        }
    }
}
