//
//  ProductionEndpoint.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/21/24.
//

import Foundation

/// A concrete implementation of `Endpoint` that will function in prod.
enum ProductionEndpoint {
    /// Fetch `getRecipesResponse`
    /// - Note; This endpoint is unpaginated
    /// - seeAlso:https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json
    case getRecipes
}

extension ProductionEndpoint: Endpoint {
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
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRecipes:
            return .get
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getRecipes:
            return []
        }
    }
}
