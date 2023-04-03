//
//  DB_Weight.swift
//  FosterApp
//
//  Created by Elora on 28/02/2023.
//

import Foundation
import CoreDataUtilsKit

extension DB_Weight: CoreDataModel {
    public static var primaryKey: String { "a_id" }
    public static var entityName: String { "DB_Weight" }
}

extension DB_Weight {
    
    func update(weight: Weight) {
        self.a_date = weight.date
        self.a_weight = weight.weight ?? 0
    }
}
