//
//  RecipeCard.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import SwiftUI

/// A RecipeCard View used to display recipes for the application.
struct RecipeCard: View {
    @EnvironmentObject private var viewModel: RecipesViewModel
    @State private var image: Image?
    private let imageLoader: ImageLoaderProtocol
    private let recipe: Recipe
    
    /// RecipeCard initializer.
    /// - Parameter recipe: The recipe used to provide information for the RecipeCard.
    init(_ recipe: Recipe) {
        self.recipe = recipe
        self.imageLoader = ImageLoader<Recipe>(recipe, cache: Cache(folderName: "RecipeImages")!)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                if let image = image {
                    image
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .redacted(reason: .placeholder)
                }
            }
            .overlay(alignment: .topTrailing) {
                VStack {
                    Text(recipe.cuisine.description)
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .truncationMode(.tail)
                }
                .cardStyle(edgeInsets: EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                .padding([.top, .trailing], 8)
            }
            
            Spacer(minLength: 0)
            
            Text(recipe.name)
                .font(.headline)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.all, 8)
            
            Spacer(minLength: 0)
        }
        .cardStyle(edgeInsets: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .task(id: viewModel.isSingleColumn) {
            if
                let imageURL = viewModel.isSingleColumn ? recipe.largeImageURL : recipe.smallImageURL,
                let (uiImage, cacheHit) = await imageLoader.loadImage(url: imageURL),
                let uiImage = uiImage
            {
                withAnimation(cacheHit ? .none : .easeIn) {
                    image = Image(uiImage: uiImage)
                }
            }
        }
    }
}

#Preview("American Recipe") {
    VStack {
        RecipeCard(Recipe.buildAmericanRecipeMock())
            .padding(.all, 16)
            .frame(width: 300, height: 300)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(UIColor.secondarySystemBackground))
}

#Preview("Malaysian Recipe") {
    VStack {
        RecipeCard(Recipe.buildMalaysianRecipeMock())
            .padding(.all, 16)
            .frame(width: 300, height: 300)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(UIColor.secondarySystemBackground))
}

#Preview("Dark Mode American Recipe") {
    VStack {
        RecipeCard(Recipe.buildAmericanRecipeMock())
            .padding(.all, 16)
            .frame(width: 300, height: 300)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(UIColor.systemGroupedBackground))
    .preferredColorScheme(.dark)
}
