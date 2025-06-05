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
                LazyVGrid(columns: viewModel.columns, spacing: 16) {
                    ForEach(viewModel.recipes, id: \.self) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeCard(recipe)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeView(recipe)
                    .padding(.horizontal, 16)
            }
            .refreshable {
                await viewModel.refreshRecipes()
            }
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGroupedBackground), ignoresSafeAreaEdges: .all)
        }
    }
}

#Preview("Recipes View") {
    RecipesView()
}

#Preview("Dark Mode Recipes View") {
    RecipesView()
        .preferredColorScheme(.dark)
}
