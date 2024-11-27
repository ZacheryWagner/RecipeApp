//
//  RecipeListRowView.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/21/24.
//

import SwiftUI

struct RecipeListRowView: View {
    private let recipe: Recipe
    private let cache: any ImageCache
    
    init(recipe: Recipe, cache: any ImageCache) {
        self.recipe = recipe
        self.cache = cache
    }
    
    var body: some View {
        content()
    }
    
    @ViewBuilder
    private func content() -> some View {
        HStack {
            image
            labelStack
        }
    }

    private var image: some View {
        return CacheableAsyncImage(
            urlString: recipe.smallPhotoURL,
            cache: cache,
            placeholder: Image(systemName: "photo")
        )
        .frame(
            width: RecipeFlowConstants.Image.small,
            height: RecipeFlowConstants.Image.small
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    private var labelStack: some View {
        VStack(alignment: .leading) {
            Text(recipe.name)
                .font(.headline)
                .fontWeight(.bold)
                .truncationMode(.tail)
            Text(recipe.cuisine)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    let saveLocationURL = FileManager.default.temporaryDirectory
    let mockCache = DiskImageCache(saveLocationURL: saveLocationURL)
    return RecipeListRowView(recipe: Recipe.mockRecipe, cache: mockCache)
}
