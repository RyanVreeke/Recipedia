//
//  RecipeView.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/4/25.
//

import SwiftUI

struct RecipeView: View {
    @State private var image: Image?
    private let imageLoader: ImageLoaderProtocol
    private let recipe: Recipe
    
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
                    ProgressView()
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
            .task {
                if
                    let largeImageURL = recipe.largeImageURL,
                    let largeUIImage = await imageLoader.loadImage(url: largeImageURL)
                {
                    image = Image(uiImage: largeUIImage)
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
