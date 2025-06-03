//
//  RecipesView.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import SwiftUI

/// View that displays a list of recipes.
struct RecipesView: View {
    @StateObject var viewModel = RecipesViewModel()
    
    init() { }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.recipes, id: \.self) { recipe in
                        VStack {
                            Text(recipe.name)
                            Text(recipe.cuisine)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                await viewModel.refreshRecipes()
            }
        }
    }
}

#Preview {
    RecipesView()
}
