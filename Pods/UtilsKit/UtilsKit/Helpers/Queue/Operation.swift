//
//  Operation.swift
//  UtilsKit
//
//  Created by RGMC on 18/10/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

/**
 Operation wrapper inheriting from Foundation.Operation managing execution with observers
 */
open class Operation: Foundation.Operation {
    
    fileprivate var _executing: Bool = false
    /**
     Indicates if the current operation is executing
     Get & set
     */
    override open var isExecuting: Bool {
        get { self._executing }
        set {
            self.willChangeValue(forKey: "isExecuting")
            _executing = newValue
            self.didChangeValue(forKey: "isExecuting")
        }
    }
    
    fileprivate var _finished: Bool = false
    /**
     Indicates if the current operation is finished
     Get & set
     */
    override open var isFinished: Bool {
        get { self._finished }
        set {
            self.willChangeValue(forKey: "isFinished")
            _finished = newValue
            self.didChangeValue(forKey: "isFinished")
        }
    }
}
