//  LitterPresenter.swift
//
//  Created by Elora on 24/02/2023.
//

import Foundation

/// `LitterPresenter` acts as the middleman between the `LitterInteractor` and `LitterViewModel`.
/// It processes data received from the interactor and updates the ViewModel.
class LitterPresenter: Presenter<LitterViewModel> {
  
	/// Updates the ViewModel based on the current layout style, rescue date, litter ID, litter, and kittens.
	/// - Parameters:
	///   - type: The layout style of the litter view.
	///   - rescueDate: The rescue date of the litter.
	///   - litterId: The identifier of the litter.
	///   - litter: The `Litter` object.
	///   - kittens: An array of `Kitten` objects.
	func displayMode(type: LitterLayoutStyle, rescueDate: Date?, litterId: String?, litter: Litter?, kittens: [Kitten]?) {
        
        if rescueDate != nil {
           let dateToString = rescueDate?.toString(format: "dd/MM/yyyy")
            self.viewModel?.rescueDate = dateToString
        }
		
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

/// Enum representing different layout styles for the litter view.
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
