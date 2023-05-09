//
//  AdvicesStruct.swift
//  FosterApp
//
//  Created by Elora on 04/05/2023.
//

import Foundation

struct AdviceStruct: Decodable {
    var category: AdvicesSectionType
    var title: String
    var body: String
}

//struct AdvicesStruct: Decodable {
//    var advices: [AdviceStruct]
//
//    func getSections() -> [AdvicesSectionType] {
//    return Array(Set(self.advices.compactMap({ $0.category })))
//    }
//
//    func getAdvices(forSection: AdvicesSectionType) -> [AdviceStruct] {
//        return advices.filter { $0.category == forSection}
//    }
//}

struct AdvicesResponse: Decodable {
    let advices: [Advice]
    
    struct Advice: Decodable {
        let category: AdvicesSectionType
        let title: String
        let advice: String
    }
    
    func getSections() -> [AdvicesSectionType] {
    return Array(Set(self.advices.compactMap({ $0.category })))
    }
    
    func getAdvices(forSection: AdvicesSectionType) -> [AdvicesResponse.Advice] {
        return advices.filter { $0.category == forSection}
    }
}
