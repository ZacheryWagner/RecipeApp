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
