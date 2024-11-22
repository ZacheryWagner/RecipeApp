//
//  NetworkServiceError.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/21/24.
//

import Foundation

enum NetworkServiceError: Error {
    case createURLFailed
    case invalidResponse(Int?)
    case decodeFailed(Error)
    case requestFailed(Error)
}

extension NetworkServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .createURLFailed:
            return "createURLFailed"
        case .invalidResponse(let statusCode):
            return "invalidResponse with Response Status Code: \(String(describing: statusCode))"
        case .decodeFailed(let error):
            return "decodeFailed with \(error.localizedDescription)"
        case .requestFailed(let error):
            return "requestFailed with \(error.localizedDescription)"
        }
    }
}
