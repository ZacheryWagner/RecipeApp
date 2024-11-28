//
//  JSONLoader.swift
//  FetchInterviewTests
//
//  Created by Zachery Wagner on 11/27/24.
//

import Foundation

class JSONLoader {
    /// Loads JSON data from a file in the bundle.
    /// - Parameter filename: The name of the JSON file (without the `.json` extension).
    /// - Returns: The data loaded from the file.
    /// - Throws: An error if the file cannot be found or its contents cannot be read.
    static func loadJSON(from filename: String) throws -> Data {
        let bundle = Bundle(for: JSONLoader.self)
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            throw NSError(domain: "JSONLoader", code: 404, userInfo: [NSLocalizedDescriptionKey: "File not found: \(filename).json"])
        }
        return try Data(contentsOf: url)
    }
}
