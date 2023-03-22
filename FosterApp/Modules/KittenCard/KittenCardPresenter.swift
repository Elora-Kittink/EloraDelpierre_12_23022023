//  KittenCardPresenter.swift
//
//  Created by Elora on 24/02/2023.
//

import Foundation
import UIKit

class KittenCardPresenter: Presenter<KittenCardViewModel> {
    
    func displayDate(date: Date, textField: UITextField) {
        let dateToString = date.toString(format: "dd/MM/yyyy") 
        
        if textField.tag == 1 {
            self.viewModel?.birthdate = dateToString
        }
        if textField.tag == 2 {
            self.viewModel?.rescueDate = dateToString
        }
        self.viewModel?.send()
    }
    
    func displayMode(type: KittenCardLayoutStyle) {
                
        self.viewModel?.isEditingMode = type.isEditingMode
        self.viewModel?.isCreatingMode = type.isCreatingMode
        self.viewModel?.isDisplayingMode = type.isDisplayingMode
        self.viewModel?.saveBtnHidden = type.saveBtnHidden
        self.viewModel?.editBtnHidden = type.editBtnHidden
        self.viewModel?.deadBtnHidden = type.deadBtnHidden
        self.viewModel?.textFieldsEnable = type.textFieldsEnable

        self.viewModel?.send()
    }
    
    func display(kitten: Kitten) {
        
        self.viewModel?.firstName = kitten.firstName ?? ""
        self.viewModel?.secondName = kitten.secondName ?? ""
        self.viewModel?.birthdate = kitten.birthdate?.toString(format: "dd/MM/yyyy") ?? ""
        // TODO: Calculate age of kitten
        let age = kitten.birthdate?.timeIntervalSinceNow
        self.viewModel?.age = "\(abs(Int(age! / 31556926.0)))"
        self.viewModel?.sex = kitten.sex ?? ""
        self.viewModel?.color = kitten.color ?? ""
        self.viewModel?.rescueDate = kitten.rescueDate.toString(format: "dd/MM/yyyy") ?? ""
//        self.viewModel?.siblings = kitten.siblings?.compactMap { sibling in
//            return sibling.firstName
//        }.joined(separator: ",") ?? ""
        self.viewModel?.comment = kitten.comment ?? ""
        self.viewModel?.isAdopted = kitten.isAdopted
        self.viewModel?.microship = String(kitten.microship ?? 0)
        self.viewModel?.vaccines = kitten.vaccines ?? []
        self.viewModel?.adopters = "\(kitten.adopters?.firstName) \(kitten.adopters?.lastName)"
        self.viewModel?.weightHistory = kitten.weightHistory ?? []
//        self.viewModel?.isFieldsEnabled =
        self.viewModel?.isAlive = kitten.isAlive
//        guard let litter = kitten.litter else { return}
//        self.viewModel?.litter = litter
    }
}

enum KittenCardLayoutStyle {
    case displaying, editing, creating
    
   var saveBtnHidden: Bool {
        switch self {
        case .displaying: return true
        case .editing: return false
        case .creating: return false
        }
    }
   var editBtnHidden: Bool {
        switch self {
        case .displaying: return false
        case .editing: return true
        case .creating: return true
        }
    }
    var deadBtnHidden: Bool {
        switch self {
        case .displaying: return false
        case .editing: return true
        case .creating: return true
        }
    }
    var textFieldsEnable: Bool {
        switch self {
        case .displaying: return false
        case .editing: return true
        case .creating: return true
        }
    }
    var isEditingMode: Bool {
        switch self {
        case .editing: return true
        case .creating: return false
        case .displaying: return false
        }
    }
    var isDisplayingMode: Bool {
        switch self {
        case .editing: return false
        case .creating: return false
        case .displaying: return true
        }
    }
    var isCreatingMode: Bool {
        switch self {
        case .editing: return false
        case .creating: return true
        case .displaying: return false
        }
    }
}
