//
//  RecipeListRowView.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/21/24.
//

import SwiftUI

struct RecipeListRowView: View {
    private let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
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
        let url = URL(string: recipe.smallPhotoURL ?? "")
        return AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure(_):
                ProgressView()
            case .empty:
                EmptyView()
            @unknown default:
                Text("Support New Case")
            }
        }
        .frame(
            width: RecipeFlowConstants.Image.small,
            height: RecipeFlowConstants.Image.small)
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
    RecipeListRowView(recipe: Recipe.mockRecipe)
}
