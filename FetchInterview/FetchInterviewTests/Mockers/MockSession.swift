//
//  MockSession.swift
//  FetchInterviewTests
//
//  Created by Zachery Wagner on 11/27/24.
//

import Foundation
import FetchInterview

class MockSession: DataRequesting {
    var responses: [URL: (Data, URLResponse)] = [:]
    var errors: [URL: Error] = [:]
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = errors[request.url!] {
            throw error
        }
        return responses[request.url!]!
    }
}
