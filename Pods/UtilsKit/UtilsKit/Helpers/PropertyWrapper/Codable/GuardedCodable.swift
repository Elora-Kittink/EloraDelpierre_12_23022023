//
//  GuardedCodable.swift
//  Total
//
//  Created by Michael Coqueret on 19/08/2021.
//  Copyright © 2021 Exomind. All rights reserved.
//

@propertyWrapper
public struct GuardedCodable<T: Codable>: Codable {
	
	public var wrappedValue: T?
	
	public init(wrappedValue: T?) {
		self.wrappedValue = wrappedValue
	}
	
	public init(from decoder: Decoder) throws {
		do {
			self.wrappedValue = try T(from: decoder)
		} catch {
			self.wrappedValue = nil
		}
	}
	
	public func encode(to encoder: Encoder) throws {
		try wrappedValue.encode(to: encoder)
	}
}

extension KeyedDecodingContainer {
	
	/// Decode GuardedCodable with nil value if error
	public func decode<T>(_ type: GuardedCodable<T>.Type,
				   forKey key: Key) throws -> GuardedCodable<T> {
		try decodeIfPresent(type, forKey: key) ?? .init(wrappedValue: nil)
	}
}
