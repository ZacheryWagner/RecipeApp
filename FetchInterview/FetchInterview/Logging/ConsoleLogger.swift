//
//  ConsoleLogger.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/26/24.
//

import Foundation

public struct ConsoleLogger: Logger {
    private let tag: String
    
    static func withTag(_ tag: String) -> ConsoleLogger {
        return ConsoleLogger(tag: tag)
    }
    
    func debug(_ message: String) {
        log(level: "DEBUG", message: message)
    }
    
    func info(_ message: String) {
        log(level: "INFO", message: message)
    }
    
    func warning(_ message: String) {
        log(level: "WARNING", message: message)
    }
    
    func error(_ error: Error) {
        log(level: "ERROR", message: error.localizedDescription)
    }
    
    func error(_ message: String) {
        log(level: "ERROR", message: message)
    }

    // MARK: - Private Helper

    private func log(level: String, message: String) {
        let timestamp = ISO8601DateFormatter().string(from: Date())
        print("[\(timestamp)] [\(level)] [\(tag)] \(message)")
    }
}
