//  AdvicesViewModel.swift
//
//  Created by Elora on 04/05/2023.
//

class AdvicesViewModel: ViewModel {
    
    var advices: AdvicesResponse?
    var sections: [AdvicesSectionType] = []
}

enum AdvicesSectionType: String, Decodable {
    case gettingStarted,
         assessingKittens = "Assessing Kittens",
         feedingKittens, bathroomBusiness, physicalHealth, behavioralHealth, preparingAdoption
    
    var title: String {
        switch self {
            
        case .gettingStarted:
            return "Se lancer"
        case .assessingKittens:
            return "Evaluer le chaton"
        case .feedingKittens:
            return "Nourrire"
        case .bathroomBusiness:
            return "La toilette"
        case .physicalHealth:
            return "La santé"
        case .behavioralHealth:
            return "Le comportement"
        case .preparingAdoption:
            return "Préparer l'adoption"
        }
    }
}

struct AdvicesSection {
    var title: AdvicesSectionType
//    var rows: []
}
