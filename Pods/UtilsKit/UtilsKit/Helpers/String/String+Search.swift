//
//  String+Search.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 17/01/2022.
//  Copyright © 2022 RGMC. All rights reserved.
//

import Foundation

extension String {

	/**
	 Self without space
	 */
	public var trimValue: String {
		self.trimmingCharacters(in: NSCharacterSet.whitespaces)
	}
	
	/**
	 Self without space or sensitive character
	 */
	public var searchValue: String {
		self
			.trimValue
			.folding(options: [.diacriticInsensitive], locale: nil).lowercased()
	}
}
