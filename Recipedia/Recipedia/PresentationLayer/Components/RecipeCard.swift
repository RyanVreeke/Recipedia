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
        VStack {
            AsyncImage(url: recipe.smallImageURL)
                .overlay(alignment: .topTrailing) {
                    Text(recipe.cuisine.displayName)
                }
            
            Text(recipe.name)
        }
    }
}
