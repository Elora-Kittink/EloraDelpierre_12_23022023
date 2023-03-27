//  KittenCardViewModel.swift
//
//  Created by Elora on 24/02/2023.
//

class KittenCardViewModel: ViewModel {
    
//    MARK: kitten datas

//    var litter: Litter!
    var firstName: String = ""
    var secondName: String = ""
    var birthdate: String = ""
    var age: String = ""
    var sex: String = ""
    var color: String = ""
    var rescueDate: String = ""
    var siblings: String = ""
    var comment: String = ""
    var isAdopted: Bool = false
    var microship: String? = ""
    var vaccines: [Vaccine] = []
    var adopters: String? = ""
    var weightHistory: [Weight] = []
    var isAlive: Bool = true
    var kitten: Kitten? 
    
//    MARK: labels names
    
    var firtsNameLabel = "Premier nom"
    var secondNameLabel = "Deuxième nom"
    var birthdateLabel = "Date de naissance / age"
    var sexLabel = "Sexe"
    var colorLabel = "Couleur"
    var rescueDateLabel = "Date de sauvetage"
    var siblingsLabel = "Fratrie"
    var commentLabel = "Commentaires"
    var microshipLabel = "Puce électronique"
    var adoptersLabel = "Adoptants"
    
//    MARK: display modes
    
    var isEditingMode = false
    var isDisplayingMode = false
    var isCreatingMode = false
    
//    MARK: button hidden
    
    var saveBtnHidden = false
    var editBtnHidden = false
    var adopteBtnHidden = false
    var deadBtnHidden = false
    
//    MARK: text fields enabled
    
    var textFieldsEnable = false
}
