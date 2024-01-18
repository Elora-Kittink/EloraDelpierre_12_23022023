//  AdvicesViewModel.swift
//
//  Created by Elora on 04/05/2023.
//

import Foundation

/// `AdvicesViewModel` represents the state and data of the `AdvicesViewController`.
class AdvicesViewModel: ViewModel {
	
    var sections: AdvicesResponse?
    var advicesUrl = URL(string: "https://raw.githubusercontent.com/Elora-Kittink/EloraDelpierre_12_23022023/b2755a2694404076afc6c0956fa6fb6b24be2b6e/FosterApp/Data/Advices/Advices.json")    
}
