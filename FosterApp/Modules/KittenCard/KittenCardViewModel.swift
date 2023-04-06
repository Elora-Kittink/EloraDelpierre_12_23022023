//  KittenCardViewModel.swift
//
//  Created by Elora on 24/02/2023.
//

class KittenCardViewModel: ViewModel {
    
    // MARK: - kitten datas
    
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
    var isAdopted = false
    var microship: String? = ""
    var vaccines: [Vaccine] = []
    var adopters: String? = ""
    var weightHistory: [Weight] = []
    var isAlive = true
    var kitten: Kitten?
    
    // MARK: - labels names
    
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
    
    var infoCardViewModel: [InfoCardViewModel] = []
}
