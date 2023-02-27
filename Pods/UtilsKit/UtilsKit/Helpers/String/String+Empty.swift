//
//  String+Empty.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 27/04/2021.
//  Copyright © 2021 RGMC. All rights reserved.
//

import Foundation

extension String {
	
	/// Return value if no empty else nil
	public var nonEmptyValue: String? {
		self.replacingOccurrences(of: " ", with: "").isEmpty ? nil : self
	}
}
