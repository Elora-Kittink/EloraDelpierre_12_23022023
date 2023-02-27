//
//  Thread+id.swift
//  UtilsKit
//
//  Created by RGMC on 17/10/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

extension Thread {
    /**
     Generate an unique identifier for the thread
     */
    public var id: String {
        if let currentOperationQueue: String = OperationQueue.current?.name {
            return currentOperationQueue
        } else if let underlyingDispatchQueue: String = OperationQueue.current?.underlyingQueue?.label {
            return underlyingDispatchQueue
        } else {
            let name: UnsafePointer<Int8> = __dispatch_queue_get_label(nil)
            return String(cString: name, encoding: .utf8) ?? Thread.current.description
        }
    }
}
