//
//  UIImage+Encode.swift
//  UtilsKit
//
//  Created by David Douard on 08/02/2021.
//

import UIKit

extension UIImage {
    
	/**
	Init UIImage from base64 string
	*/
    public convenience init?(base64String: String?) {
        guard let base64String = base64String  else { return nil }
		let temp: [String] = base64String.components(separatedBy: ",")
        var base64StringPrepared: String
        if temp.count > 1 {
			base64StringPrepared = temp[1]
        } else {
			base64StringPrepared = temp[0]
        }
        guard let data = Data(base64Encoded: base64StringPrepared, options: .ignoreUnknownCharacters) else { return nil }
        self.init(data: data)
    }
}
