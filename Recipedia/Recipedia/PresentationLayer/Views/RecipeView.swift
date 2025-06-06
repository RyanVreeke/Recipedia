//
//  RecipeView.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/4/25.
//

import SwiftUI

/// View that displays a recipe's information and links.
struct RecipeView: View {
    @State private var image: Image?
    private let imageLoader: ImageLoaderProtocol
    private let recipe: Recipe
    
    /// Initializes a RecipeView.
    /// - Parameter recipe: The recipe used to provide display information for the RecipeView.
    init(_ recipe: Recipe) {
        self.recipe = recipe
        self.imageLoader = ImageLoader(recipe, cache: Cache(folderName: "RecipeImages")!)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(recipe.name)
                            .font(.largeTitle)
                        
                        Text(recipe.cuisine.description)
                            .font(.headline)
                            
                    }
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    
                    Spacer(minLength: 0)
                }
                
                if let image = image {
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .redacted(reason: .placeholder)
                }
                
                HStack(spacing: 16) {
                    if let sourceURL = recipe.sourceURL {
                        Link(destination: sourceURL) {
                            HStack(spacing: 4) {
                                Text("Source")
                                Image(systemName: "link")
                            }
                        }
                        .buttonStyle(LinkButtonStyle(backgroundColor: .blue))
                    }
                    
                    if let videoURL = recipe.videoURL {
                        Link(destination: videoURL) {
                            HStack(spacing: 4) {
                                Text("Video")
                                Image(systemName: "movieclapper")
                            }
                        }
                        .buttonStyle(LinkButtonStyle(backgroundColor: .red))
                    }
                }
            }
            .padding(.all, 16)
            .task {
                if
                    let largeImageURL = recipe.largeImageURL,
                    let (largeUIImage, cacheHit) = await imageLoader.loadImage(url: largeImageURL),
                    let uiImage = largeUIImage
                {
                    withAnimation(cacheHit ? .none : .easeIn) {
                        image = Image(uiImage: uiImage)
                    }
                }
            }
        }
    }
}

#Preview("American Recipe") {
    VStack {
        RecipeView(Recipe.buildAmericanRecipeMock())
            .padding(.horizontal, 16)
    }
    .background(Color(UIColor.systemGroupedBackground))
}

#Preview("Malaysian Recipe") {
    VStack {
        RecipeView(Recipe.buildMalaysianRecipeMock())
            .padding(.horizontal, 16)
    }
    .background(Color(UIColor.systemGroupedBackground))
}

#Preview("Dark Mode American Recipe") {
    VStack {
        RecipeView(Recipe.buildAmericanRecipeMock())
            .padding(.horizontal, 16)
    }
    .background(Color(UIColor.systemGroupedBackground))
    .preferredColorScheme(.dark)
}
