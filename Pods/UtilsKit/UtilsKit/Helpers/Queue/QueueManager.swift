//
//  QueueManager.swift
//  Hager Services
//
//  Created by RGMC on 30/07/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

/**
 Class to manage operations stacked in a queue
 Operation are executed one by one, `isFinished` needs to be set to `true` to execute next operation
 The operations need to inherit `IdentifiableOperation`; which is an operation that can be identified (linked) to an `Identifiable`
 
 Example usage:
 - link the operation to an identifiable (such as a view controller) to avoid adding it twice in the queue
 */
public class QueueManager {
    
    /**
     Shared instance
     */
    public static let shared = QueueManager()
    
    private lazy var queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    /**
     Add operation to queue and make it dependent to previous one
     - parameter operation : the operation to link
     */
    public func add(operation: IdentifiableOperation) {
        if let lastOperation: Foundation.Operation = queue.operations.last, !queue.operations.isEmpty {
            operation.addDependency(lastOperation)
        }
        
        queue.addOperation(operation)
    }
    
    /**
     Add the given completion as an operation at the end of the queue
     - parameter completion : the completion to link
     */
    public func add(_ completion: @escaping () -> Void) {
        let blockOperation: Foundation.Operation = BlockOperation {
            completion()
        }
        
        if let lastOperation: Foundation.Operation = queue.operations.last, !queue.operations.isEmpty {
            blockOperation.addDependency(lastOperation)
        }
        
        queue.addOperation(blockOperation)
    }
    
    /**
     Stop all operation that contains given identifiable
     Pass nil or no parameters to stop all operations
     - parameter identifier : the identifiable to cancel or nil
     */
    public func stopAllOperations(withIdentifier identifier: IdentifiableObject? = nil) {
        if let identifier: IdentifiableObject = identifier {
            queue.operations.forEach { operation in
                guard let operation = operation as? IdentifiableOperation else { return }
                operation.identifiables = operation.identifiables.filter { !$0.isEqualTo(identifier) }
                if operation.identifiables.isEmpty {
                    operation.cancel()
                }
            }
        } else {
            queue.cancelAllOperations()
        }
    }
    
    
    /**
     Wait for all operations in queue
     - parameter completion: completion at the end of the queue
     */
    public func waitAllOperationsEnded(completion: @escaping () -> Void) {
        let blockOperation: Foundation.Operation = BlockOperation {
            completion()
        }
        
        if let lastOperation = self.getAllOperations().last, !queue.operations.isEmpty {
            blockOperation.addDependency(lastOperation)
        }
        
        queue.addOperation(blockOperation)
    }
    
    /**
     Get all queue operations
     - returns: all operations
     */
    public func getAllOperations() -> [Foundation.Operation] {
        self.queue.operations
    }
    
    /**
     Get the operations linked to the given identifiable
     - parameter identifier : the identifiable to search for in the operations
     - returns: all operations that contain the given identifier
     */
    internal func getOperations<T: IdentifiableOperation>(identifier: IdentifiableObject) -> [T] {
        var operations: [T] = []
        for operation in queue.operations {
            if
                let operation: T = operation as? T,
                operation.identifiables.contains(where: { $0.isEqualTo(identifier) }) && !operation.isCancelled && !operation.isFinished {
                operations.append(operation)
            }
        }
        return operations
    }
}
