//
//  DiskImageCache.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/26/24.
//

import Foundation
import CryptoKit
import UIKit

/// A concrete implementation of `Cache` for storing Images on disk.
/// TODO: Add some eviction policy, probably time based.
actor DiskImageCache: ImageCaching {
    // MARK: Properties

    private let logger: any Logger
    private let directoryLocationURL: URL
    private let fileManager: FileManager = .default
    private let compressionQuality: CGFloat

    // MARK: Init

    init(
        logger: any Logger = ConsoleLogger.withTag("\(DiskImageCache.self)"),
        saveLocationURL: URL,
        compressionQuality: CGFloat = 0.75
    ) {
        self.logger = logger
        self.directoryLocationURL = saveLocationURL
        self.compressionQuality = compressionQuality

        guard fileManager.fileExists(atPath: directoryLocationURL.path) == false else { return }
        
        do {
            try fileManager.createDirectory(
                at: directoryLocationURL,
                withIntermediateDirectories: true
            )
        } catch {
            logger.error(DiskImageCacheError.failedToCreateDirectory(error))
        }
    }

    // MARK: ImageCaching

    func setValue(_ value: UIImage?, forKey key: String) async {
        guard let value = value else {
            await removeValue(forKey: key)
            return
        }

        await performCacheWrite(image: value, key: key)
    }

    private func performCacheWrite(image: UIImage, key: String) async {
        let fileURL = self.getFileLocationURL(with: key)

        if let data = image.jpegData(compressionQuality: self.compressionQuality) {
            do {
                try data.write(to: fileURL)
            } catch {
                self.logger.error(DiskImageCacheError.failedToWrite(error, key))
            }
        }
    }

    func getValue(forKey key: String) async -> UIImage? {
        let fileURL = self.getFileLocationURL(with: key)

        guard self.fileManager.fileExists(atPath: fileURL.path) else {
            return nil
        }

        do {
            let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
            let image = UIImage(data: data)
            return image
        } catch {
            self.logger.error(DiskImageCacheError.failedToRead(error))
            return nil
        }
    }

    func removeValue(forKey key: String) async {
        let fileURL = self.getFileLocationURL(with: key)
        try? self.fileManager.removeItem(at: fileURL)
    }

    func removeAllValues() async {
        if let files = try? self.fileManager.contentsOfDirectory(
            at: self.directoryLocationURL,
            includingPropertiesForKeys: nil
        ) {
            for file in files {
                try? self.fileManager.removeItem(at: file)
            }
        }
    }

    // MARK: Helpers

    private func createCacheDirectory() async {
        guard fileManager.fileExists(atPath: directoryLocationURL.path) == false else { return }
        
        do {
            try fileManager.createDirectory(
                at: directoryLocationURL,
                withIntermediateDirectories: true
            )
        } catch {
            logger.error(DiskImageCacheError.failedToCreateDirectory(error))
        }
    }
    
    /// Creates a URL with a sanitized path component
    private func getFileLocationURL(with key: String) -> URL {
        let sanitizedKey = getSanitizedKey(key)
        return directoryLocationURL.appendingPathComponent(sanitizedKey)
    }
    
    /// Generate a consistent, file-system safe key
    private func getSanitizedKey(_ key: String) -> String {
        let data = Data(key.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
}
