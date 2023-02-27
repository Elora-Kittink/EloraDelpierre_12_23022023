//
//  Sequence+Group.swift
//  UtilsKit
//
//  Created by RGMC on 18/03/2018.
//

import Foundation

extension Sequence {
    /**
        Group a sequence by a `Hashable` value into a dictionnary
     
        - parameter key: a closure taking has parameter the iterated element and returning the key to sort sequence with.
     
        - returns: a dictionnary grouped with passed key and an array of iterated element for values.
     */
    public func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U: [Iterator.Element]] {
        var categories: [U: [Iterator.Element]] = [:]
        for element in self {
            let key: U = key(element)
            if case nil = categories[key]?.append(element) {
                categories[key] = [element]
            }
        }
        return categories
    }
}
