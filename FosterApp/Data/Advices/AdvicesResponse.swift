//
//  AdvicesStruct.swift
//  FosterApp
//
//  Created by Elora on 04/05/2023.
//

import Foundation

struct AdvicesResponse: Decodable {
    
    let sections: [Section]
    
    struct Section: Decodable {
        let sectionTitle: String
        let advices: [Advice]
    }
    
    struct Advice: Decodable {
        let title: String
        var advice: String
    }
}
//https://raw.githubusercontent.com/Elora-Kittink/EloraDelpierre_12_23022023/b2755a2694404076afc6c0956fa6fb6b24be2b6e/FosterApp/Data/Advices/Advices.json
