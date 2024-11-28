//
//  URLBuilderTests.swift
//  FetchInterviewTests
//
//  Created by Zachery Wagner on 11/27/24.
//

import Foundation
import XCTest
@testable import FetchInterview

class URLBuilderTests: XCTestCase {
    private var urlBuilder: URLBuilder!
    
    override func setUp() {
        super.setUp()
        urlBuilder = URLBuilder()
    }
    
    override func tearDown() {
        urlBuilder = nil
        super.tearDown()
    }
    
    func testBuildURL_validEndpoint_returnsCorrectURL() {
        // Arrange
        let endpoint = TestEndpoint.getRecipes
        
        // Act
        let url = urlBuilder.buildURL(from: endpoint)
        
        // Assert
        XCTAssertNotNil(url, "URL should not be nil")
        XCTAssertEqual(url?.absoluteString, "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
    }
}
