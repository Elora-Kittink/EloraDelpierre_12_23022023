//
//  Alerts.swift
//  FosterApp
//
//  Created by Elora on 24/04/2023.
//

import Foundation
import UIKit

struct Alert {
    
    var alertMessage: String
    var alertTitle: String
    var viewcontroller: UIViewController
    
    init(alertMessage: String, alertTitle: String, viewcontroller: UIViewController) {
        self.alertMessage = alertMessage
        self.alertTitle = alertTitle
        self.viewcontroller = viewcontroller
    }
    
    func showAlert() {
        let alert = UIAlertController(title: self.alertTitle, message: self.alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.viewcontroller.present(alert, animated: true, completion: nil)
        }
    }
    
//    //Show Common Alert like internet failure
//    static func showInternetFailureAlert(on vc:UIViewController){
//        showAlert(on: vc, with: internetAlertTitle, message: internetAlertMessage)
//    }
//    //Show Specific Alerts like Valid or Invalid
//    static func showInternetFailureAlert(on vc:UIViewController){
//        showAlert(on: vc, with: "Alert", message: "Invalid")
//    }
}



