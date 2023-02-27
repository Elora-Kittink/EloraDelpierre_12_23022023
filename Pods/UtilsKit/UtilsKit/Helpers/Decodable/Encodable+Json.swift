//
//  Encodable+Json.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 17/01/2022.
//  Copyright © 2022 RGMC. All rights reserved.
//

import Foundation

extension Encodable {

	/**
	 Return JSON represent object
	 */
	public func toJson(cleanNilValues: Bool = false) -> [String: AnyObject] {
		guard
			let data = try? JSONEncoder().encode(self),
			var object = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: AnyObject] else {
			return [:]
		}
		
		if cleanNilValues {
			object = object.filter { !($0.value is NSNull) }
		}
		
		return object
	}
}
