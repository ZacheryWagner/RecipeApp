//
//  MockNetworkService.swift
//  FetchInterviewTests
//
//  Created by Zachery Wagner on 11/27/24.
//

import Foundation
@testable import FetchInterview

// Mock NetworkService
class MockNetworkService: NetworkServicing {
    var endpointToTest: TestEndpoint

    init(endpointToTest: TestEndpoint) {
        self.endpointToTest = endpointToTest
    }

    func makeRequest<T: Codable>(endpoint: Endpoint) async throws -> T {
        switch endpointToTest {
        case .getRecipes:
            // Return a successful response with recipes
            let recipes = [Recipe.mockRecipe]
            let response = GetRecipesResponse(recipes: recipes)
            return response as! T
        case .getRecipesEmpty:
            // Return an empty response
            let response = GetRecipesResponse(recipes: [])
            return response as! T
        case .getRecipesMalformed:
            // Simulate a decoding error
            throw NetworkServiceError.decodeFailed(NSError(domain: "", code: -1, userInfo: nil))
        }
    }
}
