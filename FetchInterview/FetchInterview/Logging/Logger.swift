//
//  Logger.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/26/24.
//

import Foundation

protocol Logger {
    associatedtype Entity: Logger
    
    /// Creates a logger with the specified tag
    static func withTag(_ tag: String) -> Entity
    
    /// Logs a message at the `debug` level
    func debug(_ message: String)
    
    /// Logs a message at the `info` level
    func info(_ message: String)
    
    /// Logs a message at the `warning` level
    func warning(_ message: String)
    
    /// Logs a message at the `error` level
    func error(_ error: Error)
}
