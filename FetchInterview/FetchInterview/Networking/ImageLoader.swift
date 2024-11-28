//
//  ImageLoader.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/27/24.
//

import Foundation
import UIKit

public protocol ImageLoading {
    func loadImage(from urlString: String?) async throws -> UIImage?
}

/// Proxy for loading Images from the network and/or cache
class ImageLoader: ImageLoading {
    private let cache: any ImageCaching

    init(cache: any ImageCaching) {
        self.cache = cache
    }

    func loadImage(from urlString: String?) async throws -> UIImage? {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            return nil
        }

        // Check if the image is cached
        if let cachedImage = await cache.getValue(forKey: urlString) {
            return cachedImage
        }

        // Download the image data
        let (data, _) = try await URLSession.shared.data(from: url)

        // Decode the image
        if let image = UIImage(data: data) {
            // Cache the image
            await cache.setValue(image, forKey: urlString)
            return image
        }
        
        return nil
    }
}
