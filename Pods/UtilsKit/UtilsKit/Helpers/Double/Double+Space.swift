//
//  Double+Size.swift
//  UtilsKit
//
//  Created by RGMC on 06/11/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

extension Double {
    
    @available(iOS, deprecated: 13.0)
    private enum Unit: Double {
        case octet = 1
        case kiloOctet = 1e3
        case megaOctet = 1e6
        case gigaOctet = 1e9
        case teraOctet = 1e12
        case petaOctet = 1e15
        
        static let allUnits: [Unit] = [.octet, .kiloOctet, .megaOctet, .gigaOctet, .teraOctet, .petaOctet]
        var unitAbbreviation: String {
            switch self {
            case .octet: return "octet"
            case .kiloOctet: return "Ko"
            case .megaOctet: return "Mo"
            case .gigaOctet: return "Go"
            case .teraOctet: return "To"
            case .petaOctet: return "Po"
            }
        }
    }
    
    /**
     Return the formated space.
     
     - returns: the space in octet, Ko, Mo, Go, To or Po..
     */
    @available(iOS, obsoleted: 13.0, renamed: "toStorage")
    public func toSpace() -> String {
        let numberFormatter = NumberFormatter()
        guard self > 0 else {
            return "0 \(Unit.octet.unitAbbreviation)"
        }
        numberFormatter.usesSignificantDigits = true
        numberFormatter.maximumSignificantDigits = 3
        
        let val: (String, Double.Unit)? = Unit.allUnits
        .map { ((self / $0.rawValue), $0) }
        .compactMap { size, unit -> (String, Unit)? in
            guard let string = numberFormatter.string(from: NSNumber(value: size)) else { return nil }
            return (string, unit)
        }
        .reduce(nil) { result, testedResult -> (String, Unit)? in
            guard let result = result else {
                return testedResult
            }
            
            if testedResult.0.count <= result.0.count {
                return testedResult
            } else {
                return result
            }
        }
        
        guard let stringData = val else {
            return "0.0 Mo"
        }
        
        return  "\(stringData.0) \(stringData.1.unitAbbreviation)"
    }
}
