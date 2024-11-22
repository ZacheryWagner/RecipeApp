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
        case .getRecipesMalformed:
            "/recipes-malformed.json"
        case .getRecipesEmpty:
            "/recipes-empty.json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRecipesMalformed, .getRecipesEmpty:
            return .get
        }
    }
    
    var parameters: [URLQueryItem] {
        return []
    }
}
