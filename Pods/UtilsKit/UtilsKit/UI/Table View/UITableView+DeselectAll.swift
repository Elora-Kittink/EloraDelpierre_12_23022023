//
//  UITableView+DeselectAll.swift
//  UtilsKit
//
//  Created by RGMC on 13/03/2019.
//  Copyright © 2019 RGMC. All rights reserved.
//

import UIKit

extension UITableView {
    
    /**
     Deselect all visible cells
     */
    public func deselectAll(animated: Bool = true) {
        self.indexPathsForVisibleRows?.forEach { self.deselectRow(at: $0, animated: animated) }
    }
}
