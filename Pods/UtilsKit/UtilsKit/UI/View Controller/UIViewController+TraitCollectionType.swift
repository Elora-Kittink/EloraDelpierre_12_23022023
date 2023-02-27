//
//  UIViewController+TraitCollectionType.swift
//  UtilsKit
//
//  Created by RGMC on 26/11/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

/// User interface trait collection
public enum TraitCollectionType {
    
    /// Horizontal size class regular, Vertical size regular
    case regularRegular
    
    /// Horizontal size class regular, Vertical size compact
    case regularCompact
    
    /// Horizontal size class compact, Vertical size regular
    case compactRegular
    
    /// Horizontal size class compact, Vertical size compact
    case compactCompact
    
    /// Unspecified size class
    case unspecified
}

extension UIViewController {
    /**
     Trait collection type (horizontalVertical)
     */
    public var traitCollectionType: TraitCollectionType {
        switch (self.traitCollection.horizontalSizeClass, self.traitCollection.verticalSizeClass) {
        case (.regular, .regular): return .regularRegular
        case (.regular, .compact): return .regularCompact
        case (.compact, .regular): return .compactRegular
        case (.compact, .compact): return .compactCompact
        default: return .unspecified
        }
    }
}
