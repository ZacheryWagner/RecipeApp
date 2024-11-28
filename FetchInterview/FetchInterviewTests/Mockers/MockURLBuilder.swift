//
//  MockURLBuilder.swift
//  FetchInterviewTests
//
//  Created by Zachery Wagner on 11/27/24.
//

import Foundation
import FetchInterview

class MockURLBuilder: URLBuilding {
    var urls: [TestEndpoint: URL] = [:]
    
    func buildURL(from endpoint: any Endpoint) -> URL? {
        return urls[endpoint as! TestEndpoint]
    }
}
