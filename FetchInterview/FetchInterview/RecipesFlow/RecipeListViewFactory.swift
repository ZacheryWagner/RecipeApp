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
        let networkService = NetworkService()
        let viewModel = RecipeListView.ViewModel(networkService: networkService)
        return RecipeListView(viewModel: viewModel)
    }
}
