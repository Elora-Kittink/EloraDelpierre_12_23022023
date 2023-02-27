//
//  ViewReusable.swift
//  UtilsKit
//
//  Created by RGMC on 07/03/2019.
//  Copyright © 2019 RGMC. All rights reserved.
//

import Foundation
import UIKit

/**
 
 This protocol lightens view dequeuement.
 It provides methods to register, initialize and dequeue view with a single call.
 
 To make view compliants with this protocol, implement:
 
 - identifier: identifier of the view.
 
 */
public protocol ViewReusable: NibProtocol {
    static var identifier: String { get }
}
