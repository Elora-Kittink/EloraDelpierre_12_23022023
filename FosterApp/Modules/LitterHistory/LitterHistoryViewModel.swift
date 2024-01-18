//  LitterHistoryViewModel.swift
//
//  Created by Elora on 27/02/2023.
//

/// Holds the data required for the `LitterHistoryViewController`.
class LitterHistoryViewModel: ViewModel {
    
    var litters: [Litter]?
    let headerText = "Toutes les portées"
    var kittenList = "Aucun chaton"
    
    let title = "Historique des portées"
}
