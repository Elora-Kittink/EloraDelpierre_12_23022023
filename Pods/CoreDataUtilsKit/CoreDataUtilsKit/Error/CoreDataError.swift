//
//  CoreDataError.swift
//  UtilsKit
//
//  Created by RGMC on 12/05/2020.
//  Copyright © 2020 RGMC. All rights reserved.
//

import Foundation

public enum CoreDataError: Error, LocalizedError {
    
    /// The initialization of the persistent container has failed
    case unknownPersistentContainer(name: String, bundle: String?)
    
    /// The persistent container hasn't been initialized
    case noPersistentContainer
    
    public var errorDescription: String? {
        switch self {
        case .unknownPersistentContainer(let name, let bundle):
            return "Unknown \(name) persistent container in bundle \(bundle ?? "")"
            
        case .noPersistentContainer:
            return "No persitent container"
        }
    }
}
