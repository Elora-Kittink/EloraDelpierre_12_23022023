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
        let advice: String
    }
}
