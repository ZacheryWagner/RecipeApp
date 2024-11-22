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
}
