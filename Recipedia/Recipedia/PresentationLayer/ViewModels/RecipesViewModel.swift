//
//  RecipesViewModel.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import SwiftUI

/// RecipesViewModel handles the RecipesView properties and business logic.
@MainActor
final class RecipesViewModel: ObservableObject {
    @Published private(set) var recipes: [Recipe] = []
    
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 16), count: 2)
    
    private let recipeService = RecipeService.shared
    
    init() {
        Task {
            await refreshRecipes()
        }
    }
    
    func refreshRecipes() async {
        do {
            recipes = try await recipeService.getRecipes()
        } catch {
            // Reset recipes to be empty since the service failed.
            recipes = []
        }
    }
}
