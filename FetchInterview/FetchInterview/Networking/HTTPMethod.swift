//
//  HTTPMethod.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/21/24.
//

import Foundation

/// Defines possible request methods defined by `Endpoint`
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
