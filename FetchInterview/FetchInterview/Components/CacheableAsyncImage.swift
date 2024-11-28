//
//  CacheableAsyncImage.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/26/24.
//

import SwiftUI

struct CacheableAsyncImage: View {
    @State private var displayImage: UIImage?
    @State private var isLoading = false
    
    private let urlString: String?
    private let imageLoader: any ImageLoading
    private let placeholder: Image
    private let imageTransformation: (UIImage) -> Image
    
    init(
        urlString: String?,
        imageLoader: any ImageLoading,
        placeholder: Image = Image(systemName: "photo"),
        imageTransformation: @escaping (UIImage) -> Image = { Image(uiImage: $0).resizable() }
    ) {
        self.urlString = urlString
        self.imageLoader = imageLoader
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
        if let image = displayImage {
            imageTransformation(image)
        } else if isLoading {
            ProgressView()
        } else {
            placeholder
        }
    }

    private func loadImage() {
        if displayImage != nil || isLoading { return }
        isLoading = true

        Task {
            if let image = try await imageLoader.loadImage(from: urlString) {
                await updateImage(image: image)
            }
            isLoading = false
        }
    }
    
    @MainActor
    private func updateImage(image: UIImage) {
        displayImage = image
    }
}

//#Preview {
//    let saveLocationURL = FileManager.default.temporaryDirectory
//    let mockCache = DiskImageCache(saveLocationURL: saveLocationURL)
//    let mockLoader = ImageLoader(cache: mockCache)
//    let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"
//    return CacheableAsyncImage(urlString: urlString, imageLoader: mockLoader)
//}
