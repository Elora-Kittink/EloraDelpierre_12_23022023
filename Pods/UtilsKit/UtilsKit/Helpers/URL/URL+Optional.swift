//
//  URL+Optional.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 17/01/2022.
//  Copyright © 2022 RGMC. All rights reserved.
//

import Foundation

extension URL {
	
	/**
	 Init with optional string
	 */
	public init?(_ string: String?) {
		guard let string = string else {
			return nil
		}
		self.init(string: string)
	}
}
