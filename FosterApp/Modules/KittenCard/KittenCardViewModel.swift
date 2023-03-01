//  KittenCardViewModel.swift
//
//  Created by Elora on 24/02/2023.
//

class KittenCardViewModel: ViewModel {
    

    var litter: Litter = []
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
    var microship: String = ""
    var isTestsDone: Bool = false
    var vaccines: [Vaccine] = []
    var adopters: String = ""
    var weightHistory: [Weight] = []
    var isFieldsEnabled: Bool = false
    var isAlive: Bool = true
}
