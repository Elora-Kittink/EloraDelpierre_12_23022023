//
//  CollectionViewCell.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation
import UIKit

extension ViewReusable where Self: UICollectionViewCell & ViewReusable {
    
    // MARK: Register
    internal static func registerCell(withCollectionView collectionView: UICollectionView,
                                      withIdentifier identifier: String? = nil) {
        
        guard let nibName = self.nibName, !nibName.isEmpty else {
            collectionView.register(Self.self, forCellWithReuseIdentifier: identifier ?? self.identifier)
            return
        }
        collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: identifier ?? self.identifier)
    }
    
    // MARK: Dequeue
    internal static func dequeueCell(withCollectionView collectionView: UICollectionView,
                                     forIndexPath indexPath: IndexPath,
                                     withIdentifier identifier: String? = nil) -> Self? {
        
        collectionView.dequeueReusableCell(withReuseIdentifier: identifier ?? self.identifier, for: indexPath) as? Self
    }
}

extension UICollectionView {
    
    /**
     
     Register a cell in collection view
     
     The cell needs to conform to `ViewReusable` and be of type `UICollectionViewCell`.
     
     - parameter type: Type of the view to register
     
     - parameter identifier: Register the cell with the given identifier. Otherwise use identifier of `ViewReusable` instead
     
     */
    public func register<T: ViewReusable & UICollectionViewCell>(_ type: T.Type,
                                                                 withIdentifier identifier: String? = nil) {
        T.registerCell(withCollectionView: self, withIdentifier: identifier)
    }
    
    /**
     
     Register a cell class in collection view
     
     The cell needs to conform to `ViewReusable` and be of type `UICollectionViewCell`.
     
     - parameter type: Type of the view to register
     
     - parameter identifier: Register the cell with the given identifier. Otherwise use identifier of `ViewReusable` instead
     
     */
    public func registerClass<T: ViewReusable & UICollectionViewCell>(_ type: T.Type,
                                                                      withIdentifier identifier: String? = nil) {
        self.register(T.self, forCellWithReuseIdentifier: identifier ?? T.identifier)
    }
    
    /**
     
     Dequeue a cell from collection view with given cell type at given index path.
     
     The cell needs to conform to `ViewReusable`.
     
     - parameter indexPath: Index path of the cell to dequeue
     
     - returns: Dequeued cell for given type
     
     */
    public func dequeueCell<T: UICollectionViewCell & ViewReusable>(forIndexPath indexPath: IndexPath,
                                                                    withIdentifier identifier: String? = nil) -> T {
        guard let cell = T.dequeueCell(withCollectionView: self, forIndexPath: indexPath, withIdentifier: identifier) else {
            fatalError("Cannot dequeue cell \(String(describing: T.self)) with identifier \(identifier ?? T.identifier)")
        }
        return cell
    }
    
    /**
     
     Dequeue an empty cell from collection view.
     
     - parameter indexPath: Index path of the cell to dequeue
     
     - returns: an empty cell
     
     */
    public func dequeueEmptyCell(forIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        self.register(UIEmptyCollectionViewCell.self)
        let cell: UIEmptyCollectionViewCell = self.dequeueCell(forIndexPath: indexPath)
        return cell
    }
}
