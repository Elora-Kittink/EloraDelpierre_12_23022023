//
//  Extensions.swift
//  FosterApp
//
//  Created by Elora on 09/03/2023.
//

import Foundation
import UIKit


extension UIDatePicker {
    
    func setOnDateChangeListener(onDateChanged :@escaping () -> Void){
        self.addAction(UIAction(){ action in
            onDateChanged()
        }, for: .valueChanged)
    }
}
