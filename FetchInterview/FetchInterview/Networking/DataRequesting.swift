//
//  DataRequesting.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/27/24.
//

import Foundation

public protocol DataRequesting {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: DataRequesting {}
