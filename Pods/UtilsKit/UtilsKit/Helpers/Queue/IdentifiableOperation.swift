//
//  IdentifiableOperation.swift
//  UtilsKit
//
//  Created by RGMC on 15/06/2020.
//  Copyright © 2020 RGMC. All rights reserved.
//

import Foundation

/**
 Identifiable operation
 */
open class IdentifiableOperation: Operation {
    
    /**
     Linked `Identifiable` to the operation
     */
    public var identifiables: [IdentifiableObject] = []
    
    /**
     Init the operation with a single identifiable
     */
    public init(identifiable: IdentifiableObject? = nil) {
        if let identifiable: IdentifiableObject = identifiable { self.identifiables.append(identifiable) }
        super.init()
    }
    
    override open func main() {
        super.main()
        self.isExecuting = true
    }
    
    override open func start() {
        if isCancelled {
            self.isFinished = true
            return
        }
        super.start()
    }
}
