//  LitterPresenter.swift
//
//  Created by Elora on 24/02/2023.
//

import Foundation

class LitterPresenter: Presenter<LitterViewModel> {
    
    
    func displayMode(isEditing: Bool, isCreating: Bool, isDisplaying: Bool, litterId: String?) {
        if isDisplaying {
            print("Display Mode")
            self.viewModel?.id = litterId
            self.viewModel?.isEditing = false
            self.viewModel?.isCreatingNew = false
            self.viewModel?.isDisplaying = true
            self.viewModel?.saveBtnHidden = true
            self.viewModel?.editBtnHidden = false
            self.viewModel?.archiveBtnHidden = false
            self.viewModel?.favoriteBtnHidden = false
            self.viewModel?.addKittenBtnHidden = false
            self.viewModel?.isTextFieldEnable = false
            
            self.viewModel?.send()
        }
        if isEditing {
            print("Edit Mode")
            self.viewModel?.id = litterId
            self.viewModel?.isEditing = true
            self.viewModel?.isCreatingNew = false
            self.viewModel?.isDisplaying = false
            self.viewModel?.saveBtnHidden = false
            self.viewModel?.editBtnHidden = true
            self.viewModel?.archiveBtnHidden = true
            self.viewModel?.favoriteBtnHidden = true
            self.viewModel?.addKittenBtnHidden = true
//            self.viewModel?.isTextFieldEnable = true
            
            self.viewModel?.send()
        }
        if isCreating {
            
            print("Creating Mode")
            self.viewModel?.isEditing = true
            self.viewModel?.isCreatingNew = false
            self.viewModel?.isDisplaying = false
            self.viewModel?.saveBtnHidden = false
            self.viewModel?.editBtnHidden = true
            self.viewModel?.archiveBtnHidden = true
            self.viewModel?.favoriteBtnHidden = true
            self.viewModel?.addKittenBtnHidden = true
            self.viewModel?.isTextFieldEnable = true
            
            self.viewModel?.send()
        }
        
    }
    
    func editMode() {
        self.viewModel?.isEditing = true
        self.viewModel?.send()
    }
    
    func displayDate(date: Date) {
        self.viewModel?.rescueDate = date.toString(format: "dd/MM/yyyy")
        self.viewModel?.send()
    }
    
    
    func display(isEditing: Bool, isCreating: Bool, isDisplaying: Bool, litterId: String?) {
        
        self.viewModel?.id = litterId
        self.viewModel?.isEditing = isEditing
        self.viewModel?.isDisplaying = isDisplaying
        self.viewModel?.isCreatingNew = isCreating
        self.viewModel?.send()
    }
//
//    enum LayoutStyle {
//        case displaying, editing, creating
//
//        self.viewModel?.saveBtnHidden: Bool {
//            switch self {
//            case .displaying: return true
//            case .editing: return false
//            case .creating: return false
//            }
//        }
//        self.viewModel?.editBtnHidden: Bool {
//            switch self {
//            case .displaying: return false
//            case .editing: return true
//            case .creating: return true
//            }
//        }
//        self.viewModel?.archiveBtnHidden: Bool {
//            switch self {
//            case .displaying: return false
//            case .editing: return true
//            case .creating: return true
//            }
//        }
//        self.viewModel?.favoriteBtnHidden: Bool {
//            switch self {
//            case .displaying: return false
//            case .editing: return true
//            case .creating: return true
//            }
//        }
//        self.viewModel?.addKittenBtnHidden: Bool {
//            switch self {
//            case .displaying: return false
//            case .editing: return true
//            case .creating: return true
//            }
//        }
//        self.viewModel?.isTextFieldEnable: Bool {
//            switch self {
//            case .displaying: return false
//            case .editing: return true
//            case .creating: return true
//            }
//        }
//    }

}
