//
//  NetworkServiceTests.swift
//  FetchInterviewTests
//
//  Created by Zachery Wagner on 11/27/24.
//

import Foundation
import XCTest
@testable import FetchInterview

class NetworkServiceTests: XCTestCase {
    private var urlBuilder: MockURLBuilder!
    private var session: MockSession!
    private var networkService: NetworkService!
    
    override func setUp() {
        super.setUp()
        urlBuilder = MockURLBuilder()
        session = MockSession()
        networkService = NetworkService(session: session, urlBuilder: urlBuilder)
    }
    
    override func tearDown() {
        networkService = nil
        session = nil
        urlBuilder = nil
        super.tearDown()
    }
    
    func testMakeRequest_successfulResponse_decodesData() async throws {
        // Arrange
        let endpoint = TestEndpoint.getRecipes
        let mockURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        let mockResponseData = try JSONLoader.loadJSON(from: "MockGetRecipesResponse")
        let mockHTTPResponse = HTTPURLResponse(
            url: mockURL,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        urlBuilder.urls[endpoint] = mockURL
        session.responses[mockURL] = (mockResponseData, mockHTTPResponse)
        
        // Act
        do {
            let result: GetRecipesResponse = try await networkService.makeRequest(endpoint: endpoint)
            XCTAssertTrue(result.recipes.isEmpty == false, "The recipes were unexpectedly empty")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testMakeRequest_requestFailed_throwsError() async throws {
        // Arrange
        let endpoint = TestEndpoint.getRecipes
        let mockURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        let mockError = URLError(.notConnectedToInternet)
        urlBuilder.urls[endpoint] = mockURL
        session.errors[mockURL] = mockError
        
        // Act & Assert
        do {
            let _: GetRecipesResponse = try await networkService.makeRequest(endpoint: endpoint)
            XCTFail("Expected NetworkServiceError.requestFailed but no error was thrown")
        } catch let error as NetworkServiceError {
            if case .requestFailed(let innerError) = error {
                XCTAssertEqual(innerError as? URLError, mockError)
            } else {
                XCTFail("Expected NetworkServiceError.requestFailed but got \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
