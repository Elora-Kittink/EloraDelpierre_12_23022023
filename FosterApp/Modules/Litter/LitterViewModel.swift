//  LitterViewModel.swift
//
//  Created by Elora on 24/02/2023.
//

import Foundation

class LitterViewModel: ViewModel {
    
    var id: String!
    var kittens: [Kitten]?
    var isOngoing: Bool = true
    var rescueDate:  Date?
    var isDisplaying: Bool = true
    var isEditing: Bool = false
    var isCreatingNew: Bool = false
    
    var saveBtnHidden = true
    var editBtnHidden = false
    var archiveBtnHidden = false
    var favoriteBtnHidden = false
    var addKittenBtnHidden = false
    var isTextFieldEnable = false
    
}
