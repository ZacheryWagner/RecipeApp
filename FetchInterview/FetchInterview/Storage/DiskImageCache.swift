//
//  DiskImageCache.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/26/24.
//

import Foundation
import UIKit

/// A concrete implementation of `Cache` for storing Images on disk.
final actor DiskImageCache: ImageCache {
    // MARK: Properties
    
    private let logger: any Logger
    
    /// The `FileManager` `URL` to read and write from
    private let saveLocationURL: URL
    
    /// An Instance of FileManager
    private let fileManager: FileManager = FileManager.default
    
    // MARK: Init
    
    init(
        logger: any Logger = ConsoleLogger.withTag("\(DiskImageCache.self)"),
        saveLocationURL: URL
    ) {
        self.logger = logger
        self.saveLocationURL = saveLocationURL
        
        Task {
            await createCacheDirectory()
        }
    }
    
    // MARK: Cache
    
    func setValue(_ value: UIImage?, forKey key: String) {
        guard let value = value else {
            logger.warning("setValue called with nil value")
            removeFile(forKey: key)
            return
        }
        
        
        let fileURL = saveLocationURL.appendingPathComponent(key)
        if let data = value.pngData() ?? value.jpegData(compressionQuality: 1.0) {
            do {
                try data.write(to: fileURL)
            } catch {
                logger.error(DiskImageCacheError.failedToWrite(error, key))
            }
        }
    }
    
    func getValue(forKey key: String) -> UIImage? {
        let fileURL = saveLocationURL.appendingPathComponent(key)
        
        guard fileManager.fileExists(atPath: fileURL.path) else {
            logger.warning("getValue called with nonexistent file: \(fileURL.path).")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data)
        } catch {
            logger.error(DiskImageCacheError.failedToRead(error))
            return nil
        }
    }
    
    func removeValue(forKey key: String) {
        removeFile(forKey: key)
    }
    
    func removeAllValues() {
        if let files = try? fileManager.contentsOfDirectory(at: saveLocationURL, includingPropertiesForKeys: nil) {
            for file in files {
                let key = file.lastPathComponent
                removeFile(forKey: key)
            }
        }
    }
    
    // MARK: Helpers
    
    private func createCacheDirectory() async {
        if fileManager.fileExists(atPath: saveLocationURL.path) {
            do {
                try fileManager.createDirectory(at: saveLocationURL, withIntermediateDirectories: true)
            } catch {
                logger.error(DiskImageCacheError.failedToCreateDirectory(error))
            }
        }
    }
    
    private func removeFile(forKey key: String) {
        let fileURL = saveLocationURL.appendingPathComponent(key)
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                try fileManager.removeItem(at: fileURL)
            } catch {
                logger.error(DiskImageCacheError.failedToRemove(error))
            }
        }
    }
}
