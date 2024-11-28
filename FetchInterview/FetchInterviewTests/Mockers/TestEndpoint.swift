//
//  TestEndpoint.swift
//  FetchInterviewTests
//
//  Created by Zachery Wagner on 11/21/24.
//

import Foundation
import FetchInterview

/// An `Endpoint` implementation only to be used in testing.
///  - Warning: Do not use in `Production`
enum TestEndpoint {
    case getRecipes
    case getRecipesMalformed
    case getRecipesEmpty
}

extension TestEndpoint: Endpoint {
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "d3jbb8n5wk0qxi.cloudfront.net"
    }
    
    var path: String {
        switch self {
        case .getRecipes:
            "/recipes.json"
        case .getRecipesMalformed:
            "/recipes-malformed.json"
        case .getRecipesEmpty:
            "/recipes-empty.json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRecipes, .getRecipesMalformed, .getRecipesEmpty:
            return .get
        }
    }
    
    var parameters: [URLQueryItem] {
        return []
    }
}
