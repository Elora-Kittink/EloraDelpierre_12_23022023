//
//  Double+Price.swift
//  UtilsKit
//
//  Created by RGMC on 08/08/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

extension Double {
    
    /**
     Self in price with currency and formatter.
     
     - parameter currency : Custom currency if needed
     - returns: self in price with currency.
     */
    public func toPrice(currency: String? = nil) -> String {
        let numberFormatter = NumberFormatter()
        
        if let currency: String = currency {
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            if let price: String = numberFormatter.string(from: NSNumber(value: self)) {
                return "\(price) \(currency)"
            }
        } else {
            numberFormatter.numberStyle = NumberFormatter.Style.currency
            if let price: String = numberFormatter.string(from: NSNumber(value: self)) {
                return price
            }
        }
        
        return ""
    }
	
	/**
	 Self in price with currency and formatter.
	 
	 - parameter currencyCode : Currency code
	 - returns: self in price with currency.
	 */
	public func toPrice(currencyCode: String?) -> String {
		guard let currencyCode = currencyCode else {
			return self.toPrice()
		}
		
		let currency = NSLocale(localeIdentifier: currencyCode)
			.displayName(forKey: .currencySymbol, value: currencyCode)
		return self.toPrice(currency: currency ?? currencyCode)
	}
}

extension Int {
    
    /**
     Self in price with currency and formatter.
     
     - parameter currency : Custom currency if needed
     - returns: self in price with currency.
     */
    public func toPrice(currency: String? = nil) -> String {
        Double(self).toPrice(currency: currency)
    }
	
	/**
	 Self in price with currency and formatter.
	 
	 - parameter currencyCode : Currency code
	 - returns: self in price with currency.
	 */
	public func toPrice(currencyCode: String?) -> String {
		Double(self).toPrice(currencyCode: currencyCode)
	}
}
