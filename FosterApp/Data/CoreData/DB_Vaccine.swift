//
//  DB_Vaccine.swift
//  FosterApp
//
//  Created by Elora on 28/02/2023.
//

import Foundation
import CoreDataUtilsKit

extension DB_Vaccine: CoreDataModel {
    public static var primaryKey: String { "a_id" }
    public static var entityName: String { "DB_Vaccine" }
}

extension DB_Vaccine {
    
    func update(vaccine: Vaccine) {
        self.a_date = vaccine.date
        self.a_vaccine = vaccine.vaccine
        
    }
}
