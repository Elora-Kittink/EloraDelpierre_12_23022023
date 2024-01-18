//
//  DatePicker.swift
//  FosterApp
//
//  Created by Elora on 21/03/2023.
//

import Foundation
import UIKit

// TextField as DatePicker
class DatePickerField: UITextField {
    
    @IBInspectable var dateFormat: String = "dd/MM/yyyy"
// date picker, toolbar & validation button
    let datePicker = UIDatePicker()
    let toolBar = UIToolbar()
    let validate = UIBarButtonItem(title: "Valider", style: .plain, target: self, action: #selector(validateAndDismiss))


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
//	Date picker config
    private func setup() {
        datePicker.datePickerMode = .date
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        toolBar.items = [validate]
        toolBar.sizeToFit()
        self.inputAccessoryView = toolBar
        self.inputView = datePicker
    }
//    validation button action : set date into texfield & dissmiss
    @objc func validateAndDismiss() {
        self.text = datePicker.date.toString(format: "dd/MM/yyyy")
        self.parentViewController?.view.endEditing(true)
    }
}
