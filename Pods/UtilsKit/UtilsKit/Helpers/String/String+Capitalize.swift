//
//  String+Capitalize.swift
//  UtilsKit
//
//  Created by RGMC on 28/03/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

extension String {
    
    /**
        Capitalize the first letter.
     
        - returns: a new string with the first letter capitalized.
     */
    public var capitalizedFirstLetter: String {
        prefix(1).uppercased() + dropFirst()
    }
}
