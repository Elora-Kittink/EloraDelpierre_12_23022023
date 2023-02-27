//
//  UIInterfaceOrientation+Mask.swift
//  UtilsKit
//
//  Created by RGMC on 26/11/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

extension UIInterfaceOrientation {
    /**
     Interface orientation mask of this interface orientation
     */
    public var mask: UIInterfaceOrientationMask {
        switch self {
        case .unknown: return .all
        case .portrait: return .portrait
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeLeft: return .landscapeLeft
        case .landscapeRight: return .landscapeRight
        @unknown default: return .all
        }
    }
}
