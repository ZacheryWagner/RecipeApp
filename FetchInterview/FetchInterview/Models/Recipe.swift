//
//  Recipe.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/21/24.
//

import Foundation

/// A codable object representing a recipe
struct Recipe: Codable, Identifiable {
    let id: String
    let cuisine: String
    let name: String
    let largePhotoURL: String?
    let smallPhotoURL: String?
    let sourceURL: String?
    let youtubeURL: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case cuisine
        case id = "uuid"
        case largePhotoURL = "photo_url_large"
        case smallPhotoURL = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
    
    static let mockRecipe = Recipe(
        id: "1",
        cuisine: "French",
        name: "lots of food",
        largePhotoURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
        smallPhotoURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
        sourceURL: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ", youtubeURL: "https://www.youtube.com/watch?v=6R8ffRRJcrg"
    )
}
