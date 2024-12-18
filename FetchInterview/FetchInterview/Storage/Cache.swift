//
//  Cache.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/22/24.
//

import Foundation

public protocol Cache: Actor {
    associatedtype T

    /// Sets a value with a key in the cache
    /// - Parameters:
    ///   - value: The generic value to store
    ///   - key: The `String` to reference the value
    func setValue(_ value: T?, forKey key: String) async

    /// Get the `CacheEntry`s generic value with the given `key`
    /// - Parameter key: The  `String` for the desired `CacheEntry`
    /// - Returns: Returns the an optional, generic value for the `CacheEntry` associated with the `key`
    func getValue(forKey key: String) async -> T? 

    /// Remove a value from the cache
    /// - Parameter key: A `key` to find the value to remove
    func removeValue(forKey key: String) async

    /// Removed all values from the cache
    func removeAllValues() async
}
