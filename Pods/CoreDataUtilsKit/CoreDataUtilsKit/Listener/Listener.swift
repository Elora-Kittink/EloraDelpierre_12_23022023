//
//  Listener.swift
//  UtilsKit
//
//  Created by RGMC on 07/05/2020.
//  Copyright © 2020 RGMC. All rights reserved.
//

import Foundation
import CoreData

public protocol Listener: AnyObject { }

extension NSFetchedResultsController: Listener { }
