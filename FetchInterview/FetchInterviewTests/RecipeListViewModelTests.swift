//
//  RecipeListViewModelTests.swift
//  FetchInterviewTests
//
//  Created by Zachery Wagner on 11/27/24.
//

import XCTest
@testable import FetchInterview

// MARK: - Unit Tests

class RecipeListViewModelTests: XCTestCase {
    /// Test when recipes are successfully fetched
    func test_handleEvent_onAppear_successfulFetch_updatesViewStateToLoaded() async {
        // Arrange
        let networkService = MockNetworkService(endpointToTest: .getRecipes)
        let imageLoader = MockImageLoader()
        let viewModel = RecipeListView.ViewModel(
            networkService: networkService,
            imageLoader: imageLoader
        )

        // Act
        viewModel.handleEvent(.onAppear)
        // Allow async task to complete
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        // Assert
        switch viewModel.viewState {
        case .loaded(let recipes):
            XCTAssertFalse(recipes.isEmpty)
        default:
            XCTFail("Expected viewState to be .error, but was \(viewModel.viewState)")
        }
    }

    /// Test when an empty list of recipes is fetched
    func test_handleEvent_onAppear_emptyFetch_updatesViewStateToEmpty() async {
        // Arrange
        let networkService = MockNetworkService(endpointToTest: .getRecipesEmpty)
        let imageLoader = MockImageLoader()
        let viewModel = RecipeListView.ViewModel(
            networkService: networkService,
            imageLoader: imageLoader
        )

        // Act
        viewModel.handleEvent(.onAppear)

        // Allow async task to complete
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertEqual(viewModel.viewState, .empty, "Expected viewState to be .empty")
    }

    /// Test when a decoding error occurs during fetch
    func test_handleEvent_onAppear_malformedData_updatesViewStateToError() async {
        // Arrange
        let networkService = MockNetworkService(endpointToTest: .getRecipesMalformed)
        let imageLoader = MockImageLoader()
        let viewModel = RecipeListView.ViewModel(
            networkService: networkService,
            imageLoader: imageLoader
        )

        // Act
        viewModel.handleEvent(.onAppear)

        // Allow async task to complete
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        switch viewModel.viewState {
        case .error(let errorMessage):
            XCTAssertFalse(errorMessage.isEmpty, "Error message should not be empty")
        default:
            XCTFail("Expected viewState to be .error, but was \(viewModel.viewState)")
        }
    }

    /// Test handleEvent onRefresh calls fetchRecipes
    func test_handleEvent_onRefresh_callsFetchRecipes() async {
        // Arrange
        let networkService = MockNetworkService(endpointToTest: .getRecipes)
        let imageLoader = MockImageLoader()
        let viewModel = RecipeListView.ViewModel(
            networkService: networkService,
            imageLoader: imageLoader
        )

        // Act
        viewModel.handleEvent(.onRefresh)

        // Allow async task to complete
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds

        // Assert
        switch viewModel.viewState {
        case .loaded(let recipes):
            XCTAssertFalse(recipes.isEmpty)
        default:
            XCTFail("Expected viewState to be .error, but was \(viewModel.viewState)")
        }
    }
}
