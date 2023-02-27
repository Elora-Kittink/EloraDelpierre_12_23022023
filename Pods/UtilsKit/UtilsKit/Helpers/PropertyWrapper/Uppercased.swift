//
//  Uppercased.swift
//  Total
//
//  Created by Michael Coqueret on 24/06/2021.
//  Copyright © 2021 Exomind. All rights reserved.
//

@propertyWrapper
public struct Uppercased: Codable {
	
	private var value: String
	
	public var wrappedValue: String {
		get {
			self.value.uppercased()
		}
		set {
			self.value = newValue
		}
	}
	
	public init(wrappedValue: String) {
		self.value = wrappedValue
	}
}
