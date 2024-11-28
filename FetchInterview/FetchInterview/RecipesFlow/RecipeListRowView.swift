//
//  RecipeListRowView.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/21/24.
//

import SwiftUI

struct RecipeListRowView: View {
    private let recipe: Recipe
    private let imageLoader: any ImageLoading
    
    init(recipe: Recipe, imageLoader: any ImageLoading) {
        self.recipe = recipe
        self.imageLoader = imageLoader
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
            imageLoader: imageLoader,
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
    let imageLoader = ImageLoader(cache: mockCache)
    return RecipeListRowView(recipe: Recipe.mockRecipe, imageLoader: imageLoader)
}
