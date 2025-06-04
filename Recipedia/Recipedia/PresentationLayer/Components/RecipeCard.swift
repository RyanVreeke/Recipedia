//
//  RecipeCard.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import SwiftUI

/// A RecipeCard View used to display recipes for the application.
struct RecipeCard: View {
    @State private var image: Image?
    private let loader: ImageLoaderProtocol
    let recipe: Recipe
    
    
    /// RecipeCard initializer.
    /// - Parameter recipe: The recipe used to provide information for the RecipeCard.
    init(_ recipe: Recipe) {
        self.recipe = recipe
        self.loader = ImageLoader<Recipe>(recipe, cache: Cache(folderName: "RecipeImages")!)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .overlay(alignment: .topTrailing) {
                        VStack {
                            Text(recipe.cuisine.displayName)
                                .font(.headline)
                                .foregroundStyle(.primary)
                                .truncationMode(.tail)
                        }
                        .cardStyle(edgeInsets: EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        .padding([.top, .trailing], 8)
                    }
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
        .task {
            if
                let smallImageURL = recipe.smallImageURL,
                let smallUIImage = await loader.loadImage(url: smallImageURL)
            {
                image = Image(uiImage: smallUIImage)
            } else if
                let largeImageURL = recipe.largeImageURL,
                let largeUIImage = await loader.loadImage(url: largeImageURL)
            {
                image = Image(uiImage: largeUIImage)
            }
        }
    }
}
