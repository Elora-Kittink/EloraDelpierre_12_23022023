//
//  AdvicesStruct.swift
//  FosterApp
//
//  Created by Elora on 04/05/2023.
//

import Foundation

// structure used to decode the json response &
struct AdvicesResponse: Decodable {
    
    struct Section: Decodable {
        let sectionTitle: String
        let advices: [Advice]
    }
    
    struct Advice: Decodable {
        let title: String
        var advice: String
    }
	
	let sections: [Section]
}
