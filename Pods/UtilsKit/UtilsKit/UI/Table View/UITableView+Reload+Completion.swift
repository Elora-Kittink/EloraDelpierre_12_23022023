//
//  UITableView+Reload+Completion.swift
//  UtilsKit
//
//  Created by RGMC on 07/03/2019.
//  Copyright © 2019 RGMC. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
extension UITableView {
    
    /**
     Reloads the rows and sections of the table view.
     
     - parameter completion: completion call when reload complete
     */
    public func reloadData(completion: @escaping ((Bool) -> Void)) {
        self.performBatchUpdates({ [weak self] in
            self?.reloadData()
            }, completion: completion)
    }
    
    
    /**
     Reloads the specified sections using a given animation effect.
     
     - parameter sections: An index set identifying the sections to reload.
     - parameter animation: A constant that indicates how the reloading is to be animated, for example, fade out or slide out from the bottom. See UITableView.RowAnimation for descriptions of these constants. The animation constant affects the direction in which both the old and the new section rows slide. For example, if the animation constant is UITableView.RowAnimation.right, the old rows slide out to the right and the new cells slide in from the right.
     - parameter completion: completion call when reload complete
     */
    public func reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation, completion: @escaping ((Bool) -> Void)) {
        self.performBatchUpdates({ [weak self] in
            self?.reloadSections(sections, with: animation)
            }, completion: completion)
    }
    
    
    /**
     Reloads the specified rows using an animation effect.
     
     - parameter indexPaths: An array of NSIndexPath objects identifying the rows to reload.
     - parameter animation: A constant that indicates how the reloading is to be animated, for example, fade out or slide out from the bottom. See UITableView.RowAnimation for descriptions of these constants. The animation constant affects the direction in which both the old and the new section rows slide. For example, if the animation constant is UITableView.RowAnimation.right, the old rows slide out to the right and the new cells slide in from the right.
     - parameter completion: completion call when reload complete
     */
    public func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation, completion: @escaping ((Bool) -> Void)) {
        self.performBatchUpdates({ [weak self] in
            self?.reloadRows(at: indexPaths, with: animation)
            }, completion: completion)
    }
}
