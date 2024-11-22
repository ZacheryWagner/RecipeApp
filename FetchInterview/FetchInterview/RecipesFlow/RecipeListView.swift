//
//  RecipeListView.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/21/24.
//

import SwiftUI

struct RecipeListView: View {
    
    @State private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            content()
        }
        .navigationTitle("Recipes")
        .navigationBarTitleDisplayMode(.large)
        .onAppear(perform: {
            viewModel.handleEvent(.onAppear)
        })
    }
    
    @ViewBuilder
    private func content() -> some View {
        switch viewModel.viewState {
        case .loading:
            ProgressView()
        case .loaded(let recipes):
            recipeList(recipes: recipes)
                .refreshable {
                    viewModel.handleEvent(.onRefresh)
                }
        case .empty:
            ContentUnavailableView("There are no recipes.", systemImage: "magnifyingglass")
                .refreshable {
                    viewModel.handleEvent(.onRefresh)
                }
        case .error(let message):
            Text(message)
                .foregroundStyle(.red)
        }
    }
    
    @ViewBuilder
    private func recipeList(recipes: [Recipe]) -> some View {
        List(recipes) { recipe in
            Text(recipe.name)
        }
        .listStyle(.plain)
    }
}

#Preview {
    RecipeListViewFactory.create()
}
