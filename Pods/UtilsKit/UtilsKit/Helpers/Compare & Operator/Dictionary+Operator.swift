//
//  Dictionary+Operator.swift
//  UtilsKit
//
//  Created by RGMC on 29/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

extension Dictionary {

    /**
        Concat the right member dictionnary into the left one.
     
        Existing key is replaced.
     */
    public static func += <K, V> (left: inout [K: V], right: [K: V]) {
        for (kValue, vValue) in right {
            left[kValue] = vValue
        }
    }
}
