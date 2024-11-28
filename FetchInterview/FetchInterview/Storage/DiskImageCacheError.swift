//
//  DiskImageCacheError.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/26/24.
//

import Foundation

enum DiskImageCacheError: Error {
    /// Failed to Write with: Thrown Error, Key
    case failedToWrite(Error, String)
    
    /// Failed to Read with: Thrown Error
    case failedToRead(Error)
    
    /// Failed to Remove with: Thrown Error
    case failedToRemove(Error)
    
    /// Failed to Remove All with: Thrown Error
    case failedToRemoveAll(Error)
    
    /// Failed to Create File Directory with: Thrown Error
    case failedToCreateDirectory(Error)
}

extension DiskImageCacheError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToWrite(let error, let key):
            return "Failed to write to disk cache for key '\(key)': \(error.localizedDescription)"
        case .failedToRead(let error):
            return "Failed to read from disk cache: \(error.localizedDescription)"
        case .failedToRemove(let error):
            return "Failed to remove item from disk cache: \(error.localizedDescription)"
        case .failedToRemoveAll(let error):
            return "Failed to remove all items from disk cache: \(error.localizedDescription)"
        case .failedToCreateDirectory(let error):
            return "Failed to create directory for disk cache: \(error.localizedDescription)"
        }
    }
}
