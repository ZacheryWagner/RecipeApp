//
//  RecipeListView+ViewModel.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/21/24.
//

import Foundation
import UIKit

extension RecipeListView {
    @Observable
    class ViewModel {
        public var viewState: ViewState = .loading
        private var recipes = [Recipe]()

        private let logger: any Logger
        private let networkService: any NetworkServicing
        public let imageCache: any ImageCache
        
        init(
            logger: any Logger = ConsoleLogger.withTag("\(RecipeListView.ViewModel.self)"),
            networkService: any NetworkServicing,
            imageCache: any ImageCache
        ) {
            self.logger = logger
            self.networkService = networkService
            self.imageCache = imageCache
            
            logger.debug("Initialized")
        }
        
        public func handleEvent(_ event: ViewEvent) {
            Task {
                logger.debug("handleEvent: \(event)")
                switch event {
                case .onAppear, .onRefresh:
                    await fetchRecipes()
                }
            }
        }
        
        private func fetchRecipes() async {
            logger.debug("fetchRecipes")
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
        
        @MainActor
        private func updateViewState(with newState: ViewState) {
            logger.debug("updateViewState")
            viewState = newState
        }
    }
}
