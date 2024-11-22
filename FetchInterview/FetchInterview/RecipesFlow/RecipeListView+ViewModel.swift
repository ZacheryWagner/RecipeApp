//
//  RecipeListView+ViewModel.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/21/24.
//

import Foundation

extension RecipeListView {
    @Observable
    class ViewModel {
        public var viewState: ViewState = .loading
        private var recipes = [Recipe]()

        private var networkService: NetworkServicing
        init(networkService: NetworkServicing) {
            self.networkService = networkService
        }

        public func handleEvent(_ event: ViewEvent) {
            switch event {
            case .onAppear, .onRefresh:
                fetchRecipes()
            }
        }
        
        private func fetchRecipes() {
            Task {
                let endpoint = ProductionEndpoint.getRecipes
                do {
                    let responseObject: GetRecipesResponse = try await networkService.makeRequest(endpoint: endpoint)
                    guard responseObject.recipes.isEmpty == false else {
                        recipes = []
                        await updateViewState(with: .empty)
                        return
                    }

                    recipes = responseObject.recipes
                    await updateViewState(with: .loaded(recipes))
                } catch {
                    await updateViewState(with: .error(error.localizedDescription))
                }
            }
        }
        
        @MainActor
        private func updateViewState(with newState: ViewState) {
            viewState = newState
        }
    }
}
