//
//  UITableView+ResizeHeader.swift
//  UtilsKit
//
//  Created by RGMC on 08/03/2019.
//  Copyright © 2019 RGMC. All rights reserved.
//

import UIKit

extension UITableView {
    
    /**
     Resize header
     
     - parameter completion: completion call before layout superview
     */
    public func resizeHeader(completion: ((CGFloat) -> Void)? = nil) {
        
        guard let headerView = self.tableHeaderView else { return }
        let height: CGFloat = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var headerFrame: CGRect = headerView.frame
        
        if height != headerFrame.size.height {
            // Header size
            headerFrame.size.height = height
            headerView.frame = headerFrame
            self.tableHeaderView = headerView
            
            completion?(headerFrame.size.height)
            
            self.superview?.layoutIfNeeded()
        }
    }
}
