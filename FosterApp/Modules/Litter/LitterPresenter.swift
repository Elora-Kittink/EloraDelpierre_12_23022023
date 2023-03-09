//  LitterPresenter.swift
//
//  Created by Elora on 24/02/2023.
//

import Foundation

class LitterPresenter: Presenter<LitterViewModel> {
    
    
    func displayMode(litter: Litter, isDisplaying: Bool, isEditing: Bool, isCreatingNew: Bool) {
//        if isDisplaying {
//
//            self.viewModel?.id = litter.id
//            self.viewModel?.kittens = litter.kittens
//            self.viewModel?.isOngoing = litter.isOngoing
//            self.viewModel?.isEditing = false
//            self.viewModel?.rescueDate = litter.rescueDate
//            self.viewModel?.isCreatingNew = false
//            self.viewModel?.isDisplaying = true
//
//            self.viewModel?.saveBtnHidden = true
//            self.viewModel?.editBtnHidden = false
//            self.viewModel?.archiveBtnHidden = false
//            self.viewModel?.favoriteBtnHidden = false
//            self.viewModel?.addKittenBtnHidden = false
//            self.viewModel?.isTextFieldEnable = false
//        }
//        if isEditing {
//            self.viewModel?.id = litter.id
//            self.viewModel?.kittens = litter.kittens
//            self.viewModel?.isOngoing = litter.isOngoing
//            self.viewModel?.isEditing = true
//            self.viewModel?.rescueDate = litter.rescueDate
//            self.viewModel?.isCreatingNew = false
//            self.viewModel?.isDisplaying = false
//
//            self.viewModel?.saveBtnHidden = false
//            self.viewModel?.editBtnHidden = true
//            self.viewModel?.archiveBtnHidden = true
//            self.viewModel?.favoriteBtnHidden = true
//            self.viewModel?.addKittenBtnHidden = true
//            self.viewModel?.isTextFieldEnable = true
//        }
//        if isCreatingNew {
//            self.viewModel?.isOngoing = litter.isOngoing
//            self.viewModel?.isEditing = true
//            self.viewModel?.rescueDate = litter.rescueDate
//            self.viewModel?.isCreatingNew = false
//            self.viewModel?.isDisplaying = false
//
//            self.viewModel?.saveBtnHidden = false
//            self.viewModel?.editBtnHidden = true
//            self.viewModel?.archiveBtnHidden = true
//            self.viewModel?.favoriteBtnHidden = true
//            self.viewModel?.addKittenBtnHidden = true
//            self.viewModel?.isTextFieldEnable = true
//        }
        
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
