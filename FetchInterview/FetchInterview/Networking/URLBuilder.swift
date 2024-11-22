//
//  URLBuilder.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/21/24.
//

import Foundation

protocol URLBuilding {
    func buildURL(from endpoint: Endpoint) -> URL?
}

/// Builds `URL` from an `Endpoint`
class URLBuilder: URLBuilding {
    func buildURL(from endpoint: Endpoint) -> URL? {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        return components.url
    }
}
