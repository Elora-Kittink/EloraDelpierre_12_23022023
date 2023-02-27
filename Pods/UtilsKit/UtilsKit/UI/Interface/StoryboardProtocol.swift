//
//  StoryboardProtocol.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import UIKit

/**
 
 This protocol provides easy initilization for view controllers from storyboards.
 
 To make a view controller compliant with this protocol, implement:
 
 - storyboardName: name of the storyboard.
 - identifier: identifier of the view controller if set.
 
 If the identifier is not set, it assumes that the view controller is the initial view controller.
 
 */
public protocol StoryboardProtocol: AnyObject {
    
    static var storyboardName: String { get }
    static var identifier: String? { get }
}

extension StoryboardProtocol {
    
    /// View Controller identifier in storyboard
    public static var identifier: String? { nil }
    
    /**
    
    Initialize the view controller from the storyboard.
     
     - parameter infos: a closure taking as parameter the initialized view controller. It can be used to set custom values upon initialization.
     
     - returns: the view controller initialized or nil.
     
    */
    public static func fromStoryboard(_ infos: ((Self) -> Void)? = nil) -> Self {
        
        if let identifier: String = Self.identifier {
            if let controller = UIStoryboard(name: Self.storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier) as? Self {
                infos?(controller)
                return controller
            } else {
                fatalError("Cannot instantiate view controller \(String(describing: Self.self)) with indentifier \(identifier) from storyboard \(Self.storyboardName)")
            }
        } else {
            if let controller = UIStoryboard(name: Self.storyboardName, bundle: nil).instantiateInitialViewController() as? Self {
                infos?(controller)
                return controller
            } else {
                fatalError("Cannot instantiate initial view controller \(String(describing: Self.self)) from storyboard \(Self.storyboardName)")
            }
        }
    }
}
