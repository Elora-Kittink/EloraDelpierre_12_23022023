//
//  GuardedDecodable.swift
//  Total
//
//  Created by Michael Coqueret on 24/11/2020.
//  Copyright © 2020 Total. All rights reserved.
//

@propertyWrapper
public struct GuardedDecodable<T: Decodable>: Decodable {
	
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
}

extension KeyedDecodingContainer {
	
	/// Decode GuardedDecodable with nil value if error
	public func decode<T>(_ type: GuardedDecodable<T>.Type,
				   forKey key: Key) throws -> GuardedDecodable<T> {
		try decodeIfPresent(type, forKey: key) ?? .init(wrappedValue: nil)
	}
}
