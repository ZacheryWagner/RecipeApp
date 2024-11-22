//
//  Endpoint.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/21/24.
//

import Foundation

public protocol Endpoint {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [URLQueryItem] { get }
}
