//
//  MockImageLoader.swift
//  FetchInterviewTests
//
//  Created by Zachery Wagner on 11/27/24.
//

import Foundation
import UIKit
import FetchInterview

class MockImageLoader: ImageLoading {
    func loadImage(from urlString: String?) async throws -> UIImage? {
        return UIImage()
    }
}
