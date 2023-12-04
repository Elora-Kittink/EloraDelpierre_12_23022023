//  LitterPresenter.swift
//
//  Created by Elora on 24/02/2023.
//

import Foundation

class LitterPresenter: Presenter<LitterViewModel> {
  
    func displayMode(type: LitterLayoutStyle, rescueDate: Date?, litterId: String?, litter: Litter?, kittens: [Kitten]?) {
        
        if rescueDate != nil {
           let dateToString = rescueDate?.toString(format: "dd/MM/yyyy")
            self.viewModel?.rescueDate = dateToString
			print("🐣 \(self.viewModel?.rescueDate)")
        }
		print("🐹🐹 \(self.viewModel?.rescueDate)")
        self.viewModel?.isEditing = type.isEditing
        self.viewModel?.isCreatingNew = type.isCreating
        self.viewModel?.isDisplaying = type.isDisplaying
        self.viewModel?.saveBtnHidden = type.saveBtnHidden
        self.viewModel?.editBtnHidden = type.editBtnHidden
        self.viewModel?.archiveBtnHidden = type.archiveBtnHidden
        self.viewModel?.favoriteBtnHidden = type.favoriteBtnHidden
        self.viewModel?.addKittenBtnHidden = type.addKittenBtnHidden
        self.viewModel?.isTextFieldEnable = type.isTextFieldEnable
        self.viewModel?.litter = litter
        self.viewModel?.id = litterId
        if let kittens { self.viewModel?.kittens = kittens } 
        self.viewModel?.send()
    }
}

enum LitterLayoutStyle {
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
    var archiveBtnHidden: Bool {
        switch self {
        case .displaying: return false
        case .editing: return true
        case .creating: return true
        }
    }
   var favoriteBtnHidden: Bool {
        switch self {
        case .displaying: return false
        case .editing: return true
        case .creating: return true
        }
    }
    var addKittenBtnHidden: Bool {
        switch self {
        case .displaying: return false
        case .editing: return true
        case .creating: return true
        }
    }
    var isTextFieldEnable: Bool {
        switch self {
        case .displaying: return false
        case .editing: return true
        case .creating: return true
        }
    }
    var isEditing: Bool {
        switch self {
        case .editing: return true
        case .creating: return false
        case .displaying: return false
        }
    }
    var isDisplaying: Bool {
        switch self {
        case .editing: return false
        case .creating: return false
        case .displaying: return true
        }
    }
    var isCreating: Bool {
        switch self {
        case .editing: return false
        case .creating: return true
        case .displaying: return false
        }
    }
}
