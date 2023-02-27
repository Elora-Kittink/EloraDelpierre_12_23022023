//
//  CacheManager.swift
//  UtilsKit
//
//  Created by RGMC on 04/04/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

private let kUserDefaultsName = "UtilsKit.CacheManager"

/**
    Provide methods to cache and retrieve from cache codable objects.
 */
public class CacheManager: NSObject {
    
    /// The shared singleton AlertManager object
    public static var shared = CacheManager()
    
    private let cache = UserDefaults(suiteName: kUserDefaultsName)
    
    /**
     Cache data with key.
     
     The data needs to conforms to Codable protocol.
    
     - parameter object: the data compliant with `Codable` protocol.
     
     - parameter key: the key of the data to save under.
     */
    public func set<T: Codable>(_ object: T, key: String) {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData: Encodable = try jsonEncoder.encode(object)
            cache?.set(jsonData, forKey: key)
            cache?.synchronize()
        } catch {
            log(.biometry, "Set \(object)", error: error)
        }
    }
    
    /**
     Retrieve data from cache corresponding to key.
     
     The data needs to conforms to Codable protocol.
     
     `nil` means no data or an error during decoding.
     
     - parameter key: the key of the data to retrieve.
     
     - returns: the retrieved data or nil.
     */
    public func get<T: Codable>(forKey key: String?) -> T? {
        guard let key = key else { return nil }
        let data: Data? = cache?.data(forKey: key)
        let object = try? T.decode(from: data)
        return object
    }
    
    /**
        Delete from cache data corresponding to key.
     
        - parameter key: the key of the data to delete.
     */
    public func delete(_ key: String) {
        cache?.set(nil, forKey: key)
    }
    
    public func resetCache() {
        cache?.removePersistentDomain(forName: kUserDefaultsName)
    }
}
