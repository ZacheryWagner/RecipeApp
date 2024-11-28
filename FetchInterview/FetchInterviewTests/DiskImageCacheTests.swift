//
//  DiskImageCacheTests.swift
//  FetchInterviewTests
//
//  Created by Zachery Wagner on 11/27/24.
//

import Foundation
import XCTest
@testable import FetchInterview

// MARK: - Unit Tests

class DiskImageCacheTests: XCTestCase {
    
    var cacheDirectoryURL: URL!
    var diskImageCache: DiskImageCache!
    var testImage: UIImage!
    
    override func setUp() {
        super.setUp()
        
        // Create a temporary directory for the cache
        let tempDirectory = NSTemporaryDirectory()
        cacheDirectoryURL = URL(fileURLWithPath: tempDirectory).appendingPathComponent(UUID().uuidString)
        
        // Initialize the DiskImageCache with the temporary directory
        diskImageCache = DiskImageCache(
            saveLocationURL: cacheDirectoryURL,
            compressionQuality: 1.0
        )
        
        // Create a test image
        testImage = UIImage(systemName: "star")!
    }
    
    override func tearDown() {
        // Clean up the temporary directory
        try? FileManager.default.removeItem(at: cacheDirectoryURL)
        cacheDirectoryURL = nil
        diskImageCache = nil
        testImage = nil
        
        super.tearDown()
    }
    
    /// Test setting and getting a single image
    func test_setAndGetImage() async {
        let key = "testImageKey"
        
        // Set the image
        await diskImageCache.setValue(testImage, forKey: key)
        
        // Get the image
        let cachedImage = await diskImageCache.getValue(forKey: key)
        
        // Assert that the cached image is not nil
        XCTAssertNotNil(cachedImage)
    }
    
    /// Test removing an image
    func test_removeImage() async {
        let key = "testImageKey"
        
        // Set the image
        await diskImageCache.setValue(testImage, forKey: key)
        
        // Remove the image
        await diskImageCache.removeValue(forKey: key)
        
        // Try to get the image
        let cachedImage = await diskImageCache.getValue(forKey: key)
        
        // Assert that the cached image is nil
        XCTAssertNil(cachedImage)
    }
    
    /// Test removing all images
    func test_removeAllImages() async {
        let keys = ["image1", "image2", "image3"]
        
        // Set multiple images
        for key in keys {
            await diskImageCache.setValue(testImage, forKey: key)
        }
        
        // Remove all images
        await diskImageCache.removeAllValues()
        
        // Assert that all images are removed
        for key in keys {
            let cachedImage = await diskImageCache.getValue(forKey: key)
            XCTAssertNil(cachedImage)
        }
    }
    
    /// Test concurrent access to set and get images
    func test_concurrentAccess() async {
        let key = "concurrentImageKey"
        let concurrentQueue = DispatchQueue(label: "com.test.concurrentQueue", attributes: .concurrent)
        let expectation = XCTestExpectation(description: "Concurrent Access")
        expectation.expectedFulfillmentCount = 50 // Number of concurrent operations
        
        // Perform concurrent writes and reads
        for _ in 0..<25 {
            concurrentQueue.async {
                Task {
                    await self.diskImageCache.setValue(self.testImage, forKey: key)
                    expectation.fulfill()
                }
            }
            
            concurrentQueue.async {
                Task {
                    let _ = await self.diskImageCache.getValue(forKey: key)
                    expectation.fulfill()
                }
            }
        }

        // Wait for expectations
        await fulfillment(of: [expectation], timeout: 5.0)
        
        
        // Verify that the image is correctly cached
        let cachedImage = await diskImageCache.getValue(forKey: key)
        XCTAssertNotNil(cachedImage)
    }
    
    // Test setting nil value removes the image
    func test_setNilValueRemovesImage() async {
        let key = "testImageKey"
        
        // Set the image
        await diskImageCache.setValue(testImage, forKey: key)
        
        // Set nil value
        await diskImageCache.setValue(nil, forKey: key)
        
        // Get the image
        let cachedImage = await diskImageCache.getValue(forKey: key)
        
        // Assert that the cached image is nil
        XCTAssertNil(cachedImage)
    }
}
