//
//  CacheableAsyncImage.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/26/24.
//

import SwiftUI

struct CacheableAsyncImage: View {
    @State private var uiImage: UIImage?
    @State private var isLoading = false
    
    private let urlString: String?
    private let cache: any ImageCache
    private let placeholder: Image
    private let imageTransformation: (UIImage) -> Image
    
    init(
        urlString: String?,
        cache: any ImageCache,
        placeholder: Image = Image(systemName: "photo"),
        imageTransformation: @escaping (UIImage) -> Image = { Image(uiImage: $0).resizable() }
    ) {
        self.urlString = urlString
        self.cache = cache
        self.placeholder = placeholder
        self.imageTransformation = imageTransformation
    }
    
    var body: some View {
        content
            .onAppear {
                loadImage()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        if let uiImage = uiImage {
            imageTransformation(uiImage)
        } else if isLoading {
            ProgressView()
        } else {
            placeholder
        }
    }

    // TODO: Implement a proper `ImageLoader` to decouple loading from presenting.
    private func loadImage() {
        if uiImage != nil || isLoading {
            return
        }
        
        isLoading = true
        
        Task {
            // If we don't have a valid url, we rely on the placeholder.
            guard let urlString = urlString,
                    let url = URL(string: urlString) else {
                isLoading = false
                return
            }
            
            // Check if the image is cached.
            if let cachedImage = await cache.getValue(forKey: url.absoluteString) {
                uiImage = cachedImage
                isLoading = false
                return
            }
            
            // Download the image from the network.
            let (data, _) = try await URLSession.shared.data(from: url)
            if let downloadedImage = UIImage(data: data) {
                // Cache the image
                await cache.setValue(downloadedImage, forKey: url.absoluteString)
                uiImage = downloadedImage
            }
            isLoading = false
        }
    }
}

#Preview {
    let saveLocationURL = FileManager.default.temporaryDirectory
    let mockCache = DiskImageCache(saveLocationURL: saveLocationURL)
    let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"
    return CacheableAsyncImage(urlString: urlString, cache: mockCache)
}
