 //
 //  ViewReusable.swift
 //  UtilsKit
 //
 //  Created by RGMC on 28/03/2018.
 //  Copyright © 2018 RGMC. All rights reserved.
 //
 
 import Foundation
 import UIKit
 
 // MARK: - Cell
 extension ViewReusable where Self: UITableViewCell {
    
    // MARK: Register
    internal static func registerCell(withTableview tableview: UITableView,
                                      forCellReuseIdentifier identifier: String? = nil) {
        
        guard let nibName = self.nibName else {
            tableview.register(Self.self, forCellReuseIdentifier: identifier ?? self.identifier)
            return
        }
        tableview.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: identifier ?? self.identifier)
    }
    
    // MARK: Dequeue cell with indexpath
    internal static func dequeueCell(withTableView tableView: UITableView,
                                     forIndexPath indexPath: IndexPath,
                                     withIdentifier identifier: String? = nil) -> Self? {
        tableView.dequeueReusableCell(withIdentifier: identifier ?? self.identifier, for: indexPath) as? Self
    }
    
    // MARK: Dequeue cell without indexpath
    internal static func dequeueCell(withTableView tableView: UITableView,
                                     withIdentifier identifier: String? = nil) -> Self? {
        tableView.dequeueReusableCell(withIdentifier: identifier ?? self.identifier) as? Self
    }
 }
 
 // MARK: - Header/Footer
 extension ViewReusable where Self: UITableViewHeaderFooterView {
    
    // MARK: Register
    internal static func registerHeaderFooterView(withTableview tableview: UITableView,
                                                  withIdentifier identifier: String? = nil) {
        
        guard let nibName = Self.nibName else { return }
        tableview.register(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: identifier ?? self.identifier)
    }
    
    // MARK: Dequeue header or footer view
    internal static func dequeueHeaderFooterView(withTableView tableView: UITableView,
                                                 withIdentifier identifier: String? = nil) -> Self? {
        
        tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier ?? self.identifier) as? Self
    }
 }
 
 extension UITableView {
    
    /**
     
     Register a cell in table view
     
     The cell needs to conform to `ViewReusable` and be of type `UITableViewCell`.
          
     - parameter type: Type of the view to register
     
     - parameter identifier: Register the cell with the given identifier. Otherwise use identifier of `ViewReusable` instead
     
     */
    public func register<T: ViewReusable & UITableViewCell>(_ type: T.Type, withIdentifier identifier: String? = nil) {
        T.registerCell(withTableview: self, forCellReuseIdentifier: identifier)
    }
    
    /**
     
     Dequeue a cell from table view with given cell type.
     
     The cell needs to conform to `ViewReusable` and be of type `UITableViewCell`.
               
     - parameter identifier: Dequeue the cell with the given identifier. Otherwise use identifier of `ViewReusable` instead

     - returns: Dequeued cell for given type
     
     */
    public func dequeueCell<T: ViewReusable & UITableViewCell>(withIdentifier identifier: String? = nil) -> T {
        guard let cell = T.dequeueCell(withTableView: self, withIdentifier: identifier) else {
            fatalError("Cannot dequeue cell \(String(describing: T.self)) with identifier \(identifier ?? T.identifier)")
        }
        return cell
    }
    
    /**
     
     Dequeue a cell from table view with given cell type at given index path.
     
     The cell needs to conform to `ViewReusable` and be of type `UITableViewCell`.
          
     - parameter indexPath: Index path of the cell to dequeue
     
     - parameter identifier: Dequeue the cell with the given identifier. Otherwise use identifier of `ViewReusable` instead

     - returns: Dequeued cell for given type
     
     */
    public func dequeueCell<T: ViewReusable & UITableViewCell>(forIndexPath indexPath: IndexPath,
                                                               withIdentifier identifier: String? = nil) -> T {
        guard let cell = T.dequeueCell(withTableView: self, forIndexPath: indexPath, withIdentifier: identifier) else {
            fatalError("Cannot dequeue cell \(String(describing: T.self)) with identifier \(identifier ?? T.identifier)")
        }
        return cell
    }
    
    /**
     
     Register a header or footer view in table view
     
     The view needs to conform to `ViewReusable` and be of type `UITableHeaderFooterView`.
          
     - parameter type: Type of the view to register
     
     - parameter identifier: Register the view with the given identifier. Otherwise use identifier of `ViewReusable` instead
     
     */
    public func register<T: ViewReusable & UITableViewHeaderFooterView>(_ type: T.Type, withIdentifier identifier: String? = nil) {
        T.registerHeaderFooterView(withTableview: self, withIdentifier: identifier)
    }
    
    /**
     
     Dequeue header or footer view from table view
     
     The view needs to conform to `ViewReusable` and be of type `UITableViewHeaderFooterView`.
          
     - parameter identifier: Dequeue the view with the given identifier. Otherwise use identifier of `ViewReusable` instead

     - returns: Dequeued view for given type
     
     */
    public func dequeueHeaderFooterView<T: ViewReusable & UITableViewHeaderFooterView>(withIdentifier identifier: String? = nil) -> T {
        guard let view = T.dequeueHeaderFooterView(withTableView: self, withIdentifier: identifier) else {
            fatalError("Cannot dequeue header or footer view \(String(describing: T.self)) with identifier \(identifier ?? T.identifier)")
        }
        return view
    }
 }
 
