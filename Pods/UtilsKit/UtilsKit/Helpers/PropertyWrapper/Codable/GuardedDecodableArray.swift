//
//  GuardedDecodableArray.swift
//  Total
//
//  Created by Michael Coqueret on 19/08/2021.
//  Copyright © 2021 Exomind. All rights reserved.
//

@propertyWrapper
public struct GuardedDecodableArray<T: Decodable>: Decodable {
	
	private struct AnyDecodableValue: Codable { }
	
	public var wrappedValue: [T]
	
	public init(wrappedValue: [T]) {
		self.wrappedValue = wrappedValue
	}
	
	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		
		var elements: [T] = []
		
		while !container.isAtEnd {
			do {
				let value = try container.decode(T.self)
				elements.append(value)
			} catch {
				_ = try? container.decode(AnyDecodableValue.self)
				log(.data, "Decode", error: error)
			}
		}
		
		self.wrappedValue = elements
	}
}

extension KeyedDecodingContainer {
	
	/// Decode GuardedDecodableArray with empty array if error
	public func decode<T>(_ type: GuardedDecodableArray<T>.Type,
				   forKey key: Key) throws -> GuardedDecodableArray<T> {
		try decodeIfPresent(type, forKey: key) ?? .init(wrappedValue: [])
	}
}
