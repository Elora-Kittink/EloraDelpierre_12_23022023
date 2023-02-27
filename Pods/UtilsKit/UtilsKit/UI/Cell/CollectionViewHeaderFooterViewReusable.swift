//
//  CollectionViewReusableViewKind.swift
//  UtilsKit
//
//  Created by RGMC on 07/05/2020.
//  Copyright © 2020 RGMC. All rights reserved.
//

import Foundation
import UIKit

/**
 Wrapper of reusable view kind
 */
public enum CollectionViewReusableViewKind {
    
    /// CollectionView section header kind
    case header
    
    /// CollectionView section footer kind
    case footer
    
    fileprivate var rawValue: String {
        switch self {
        case .header: return UICollectionView.elementKindSectionHeader
        case .footer: return UICollectionView.elementKindSectionFooter
        }
    }
}

/**
 
 This protocol lightens collection view reusable view dequeuement.
 It provides methods to register, initialize and dequeue view with a single call.
 
 To make reusable view compliants with this protocol, implement:
 
 - nibName: name of the xib
 - identifier: identifier of the view
 - kind: kind of view. Either `header` or `footer`
 
 */
public protocol CollectionViewHeaderFooterViewReusable: ViewReusable {
    static var kind: CollectionViewReusableViewKind { get }
}

extension CollectionViewHeaderFooterViewReusable where Self: UICollectionReusableView {
    
    // MARK: Register
    internal static func registerView(withCollectionView collectionView: UICollectionView,
                                      withIdentifier identifier: String? = nil) {
        
        guard let nibName = Self.nibName else { return }

        if nibName.isEmpty {
            collectionView.register(Self.self, forSupplementaryViewOfKind: self.kind.rawValue, withReuseIdentifier: identifier ?? self.identifier)
        } else {
            collectionView.register(UINib(nibName: nibName, bundle: nil),
                                    forSupplementaryViewOfKind: self.kind.rawValue,
                                    withReuseIdentifier: identifier ?? self.identifier)
        }
    }
    
    // MARK: Dequeue
    internal static func dequeueViewAux(withCollectionView collectionView: UICollectionView,
                                        forIndexPath indexPath: IndexPath,
                                        withIdentifier identifier: String? = nil) -> Self? {
        
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: self.kind.rawValue,
                                                                         withReuseIdentifier: identifier ?? self.identifier,
                                                                         for: indexPath) as? Self
        else {
            return nil
        }
        
        return view
    }
    
    internal static func dequeueView(withCollectionView collectionView: UICollectionView,
                                     forIndexPath indexPath: IndexPath,
                                     withIdentifier identifier: String? = nil) -> Self? {
        
        self.registerView(withCollectionView: collectionView, withIdentifier: identifier)
        return dequeueViewAux(withCollectionView: collectionView, forIndexPath: indexPath, withIdentifier: identifier)
    }
}

extension UICollectionView {
    
    /**
     
     Dequeue a header or footer view from collection view with given view type at given index path.
     
     The reusable view needs to conform to `CollectionViewHeaderFooterViewReusable`.
     
     This methods initializes and registers the view if needed.
     
     - parameter indexPath: Index path of the view to dequeue
     
     - returns: Dequeued view for given type
     
     */
    public func dequeueView<T: CollectionViewHeaderFooterViewReusable & UICollectionReusableView>(forIndexPath indexPath: IndexPath,
                                                                                                  withIdentifier identifier: String? = nil) -> T {
        
        guard let view = T.dequeueView(withCollectionView: self, forIndexPath: indexPath, withIdentifier: identifier) else {
            fatalError("Cannot dequeue view \(String(describing: T.self)) with identifier \(identifier ?? T.identifier)")
        }
        return view
    }
}
