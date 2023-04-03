//  KittenCardPresenter.swift
//
//  Created by Elora on 24/02/2023.
//

import Foundation
import UIKit

class KittenCardPresenter: Presenter<KittenCardViewModel> {
    
    func displayMode(type: KittenCardLayoutStyle) {
                
        self.viewModel?.isEditingMode = type.isEditingMode
        self.viewModel?.isCreatingMode = type.isCreatingMode
        self.viewModel?.isDisplayingMode = type.isDisplayingMode
        self.viewModel?.validateCreationBtnHidden = type.validateCreationBtnHidden
        self.viewModel?.validateModifBtnHidden = type.validateModifBtnHidden
        self.viewModel?.editBtnHidden = type.editBtnHidden
        self.viewModel?.deadBtnHidden = type.deadBtnHidden
        self.viewModel?.adopteBtnHidden = type.adopteBtnHidden
        self.viewModel?.textFieldsEnable = type.textFieldsEnable

        self.viewModel?.send()
    }
    
    func display(kitten: Kitten, litter: Litter) {
        
        self.viewModel?.firstName = kitten.firstName ?? "A compléter"
        self.viewModel?.secondName = kitten.secondName ?? ""
        self.viewModel?.birthdate = kitten.birthdate?.toString(format: "dd/MM/yyyy") ?? "A compléter"
        // TODO: Calculate age of kitten
        let age = kitten.birthdate?.timeIntervalSinceNow
        self.viewModel?.age = "\(abs(Int((age ?? 0) / 31_556_926.0)))"
        self.viewModel?.sex = kitten.sex ?? "A compléter"
        self.viewModel?.color = kitten.color ?? "A compléter"
        self.viewModel?.rescueDate = kitten.rescueDate?.toString(format: "dd/MM/yyyy") ?? "A compléter"
        let siblings = litter.kittens?.filter { kitty in
            kitten.id != kitty.id
        }

        self.viewModel?.siblings = siblings?.compactMap { sibling in
             sibling.firstName
        }
        .joined(separator: ", ") ?? ""

        self.viewModel?.comment = kitten.comment ?? "A compléter"
        self.viewModel?.isAdopted = kitten.isAdopted
        self.viewModel?.microship = String(kitten.microship ?? 0)
        self.viewModel?.vaccines = kitten.vaccines ?? []
        self.viewModel?.adopters = "\(kitten.adopters?.firstName) \(kitten.adopters?.lastName)"
        self.viewModel?.weightHistory = kitten.weightHistory ?? []
//        self.viewModel?.isFieldsEnabled =
        self.viewModel?.isAlive = kitten.isAlive
//        guard let litter = kitten.litter else { return}
//        self.viewModel?.litter = litter
        self.viewModel?.kitten = kitten
    }
}

enum KittenCardLayoutStyle {
    case displaying, editing, creating
    
   var validateCreationBtnHidden: Bool {
        switch self {
        case .displaying: return true
        case .editing: return true
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
    var validateModifBtnHidden: Bool {
        switch self {
        case .displaying: return true
        case .editing: return false
        case .creating: return true
        }
    }
    var adopteBtnHidden: Bool {
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
