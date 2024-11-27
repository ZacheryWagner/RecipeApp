//
//  RecipeListViewFactory.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/21/24.
//

import Foundation

/// A factory responsible for creating instances of `RecipeListView` with its dependencies.
struct RecipeListViewFactory {
    /// Creates an instance of `RecipeListView`.
    /// - Returns: A fully configured `RecipeListView`.
    static func create() -> RecipeListView {
        var saveLocationURL = FileManager.default.temporaryDirectory
        if let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            saveLocationURL = url
        } else {
            ConsoleLogger.withTag("\(RecipeListViewFactory.self)").warning(
                "DiskImageCache created with temporaryDirectory and will not persist between sessions."
            )
        }

        let cache = DiskImageCache(saveLocationURL: saveLocationURL)
        let networkService = NetworkService()
        let viewModel = RecipeListView.ViewModel(
            networkService: networkService,
            imageCache: cache)
        return RecipeListView(viewModel: viewModel)
    }
}
