//
//  GetRecipesResponse.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/21/24.
//

import Foundation

/// The expected response object from the `getRecipe` endpoint.
struct GetRecipesResponse: Codable {
    let recipes: [Recipe]
}
