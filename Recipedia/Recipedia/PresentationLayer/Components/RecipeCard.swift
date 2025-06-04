//
//  RecipeCard.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe
    
    init(_ recipe: Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: recipe.smallImageURL) { result in
                result.image?
                    .resizable()
                    .scaledToFit()
            }
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
    }
}
