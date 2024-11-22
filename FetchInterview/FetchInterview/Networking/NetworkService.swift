//
//  NetworkService.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/21/24.
//

import Foundation

protocol NetworkServicing {
    /// Makes an asynchronous request to the specified endpoint and decodes the response.
    /// - Parameter endpoint: The endpoint to build the rquest with.
    /// - Returns: A decoded instance of the specified `Codable` type `T`.
    /// - Throws: `Error` if there was an error buidling the URL, making the request, or decoding the response.
    func makeRequest<T: Codable>(endpoint: Endpoint) async throws -> T
}

/// A concrete implementation of the `NetworkServicing` protocol that performs
/// requests using `URLSession` and decodes JSON responses.
class NetworkService: NetworkServicing {
    
    // MARK: Properties
    
    /// The URL session used for executing network requests.
    private let session: URLSession
    
    /// A URL builder responsible for constructing valid URLs from `Endpoint` objects.
    private let urlBuilder: URLBuilding
    
    // MARK: Init
    
    /// Initializes a `NetworkService` with the specified `URLSession` and `URLBuilding` implementation.
    /// - Parameters:
    ///   - session: The `URLSession` to use for network requests. Defaults to `.shared`.
    ///   - urlBuilder: The `URLBuilding` implementation to use for creating URLs. Defaults to a new instance of `URLBuilder`.
    init(session: URLSession = .shared, urlBuilder: URLBuilding = URLBuilder()) {
        self.session = session
        self.urlBuilder = urlBuilder
    }
    
    // MARK: NetworkServicing
    
    /// Makes an asynchronous request to the specified endpoint and decodes the response.
    /// - Parameter endpoint: The endpoint to build the rquest with.
    /// - Returns: A decoded instance of the specified `Codable` type `T`.
    /// - Throws:
    ///   - `NetworkServiceError.createURLFailed` if the URL creation fails.
    ///   - `NetworkServiceError.invalidResponse` if the server response is invalid or has a non-success status code.
    ///   - `NetworkServiceError.decodeFailed` if decoding the response data fails.
    ///   - `NetworkServiceError.requestFailed` If the session.data throws and error.
    func makeRequest<T>(endpoint: any Endpoint) async throws -> T where T : Decodable, T : Encodable {
        guard let url = urlBuilder.buildURL(from: endpoint) else {
            throw NetworkServiceError.createURLFailed
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        do {
            let (data, response) = try await session.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkServiceError.invalidResponse(nil)
            }
            
            guard response.isSuccess else {
                throw NetworkServiceError.invalidResponse(response.statusCode)
            }
            
            return try decode(data: data)
        } catch {
            throw NetworkServiceError.requestFailed(error)
        }
    }
    
    // MARK: Helpers

    /// Decodes the given JSON data into the specified `Decodable` type.
    /// - Parameter data: The JSON data to decode.
    /// - Returns: A decoded instance of type `T`.
    /// - Throws: `NetworkServiceError.decodeFailed` if decoding fails.
    private func decode<T: Decodable>(data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkServiceError.decodeFailed(error)
        }
    }
}