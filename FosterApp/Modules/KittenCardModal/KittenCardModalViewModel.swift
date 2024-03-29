//  KittenCardModalViewModel.swift
//
//  Created by Elora on 03/04/2023.
//

/// Holds the data required for the `KittenCardModalViewController`.
class KittenCardModalViewModel: ViewModel {
    
	// Properties for labels, kitten data, and other UI elements.
    let newKittenTitle = "Nouveau chaton"
    let updateKittenTitle = "Modifier le chaton"
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
	var tattooLabel = "Tatouage"
    var adoptersLabel = "Adoptants"
    
    // MARK: - kitten datas

    //    var litter: Litter!
        var firstName: String = ""
        var secondName: String = ""
        var birthdate: String = ""
        var age: String = ""
        var sex: Int = 0
        var color: String = ""
        var rescueDate: String = ""
        var siblings: String = ""
        var comment: String = ""
        var isAdopted = false
        var microship: String? = ""
		var tattoo: String = ""
//        var vaccines: [Vaccine] = []
        var adopters: String? = ""
//        var weightHistory: [Weight] = []
        var isAlive: Int = 0
        var kitten: Kitten?
}
