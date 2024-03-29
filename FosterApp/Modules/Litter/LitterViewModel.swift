//  LitterViewModel.swift
//
//  Created by Elora on 24/02/2023.
//

import Foundation

/// Holds the data required for the `LitterViewController`.
class LitterViewModel: ViewModel {
    
    var litter: Litter!
    
    var id: String!
    var kittens: [Kitten]?
    var isOngoing = true
    var rescueDate: String?
    var isDisplaying = true
    var isEditing = false
    var isCreatingNew = false
    
    var saveBtnHidden = true
    var editBtnHidden = false
    var archiveBtnHidden = false
    var favoriteBtnHidden = false
    var addKittenBtnHidden = false
    var isTextFieldEnable = true
	
	var dateFormat = "dd/MM/yyyy"
    
    let title = "Portée"
}
