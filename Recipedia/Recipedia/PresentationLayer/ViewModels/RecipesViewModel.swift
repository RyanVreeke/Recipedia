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
    @Published private(set) var filteredRecipes: [Recipe] = []
    @Published var searchText: String = "" {
        didSet { filterRecipes() }
    }
    @Published private(set) var selectedCuisines: [Cuisine] = [] {
        didSet { filterRecipes() }
    }
    @Published var viewState: ViewState = .loading
    @Published var isSingleColumn: Bool = false {
        didSet {
            if(isSingleColumn) {
                columns = [GridItem(.flexible())]
            } else {
                columns = Array(repeating: .init(.flexible(), spacing: 16), count: 2)
            }
        }
    }
    
    var columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 16), count: 2)
    
    private let recipeService = RecipeService.shared
    
    init() {
        Task {
            await refreshRecipes()
        }
    }
    
    func refreshRecipes() async {
        do {
            recipes = try await recipeService.getRecipes()
            
            filterRecipes()
            
            viewState = recipes.isEmpty ? .empty : .loaded
        } catch {
            // Reset recipes to be empty since the service failed.
            recipes = []
            
            viewState = .error
        }
    }
    
    func toggleCuisineSelection(_ cuisine: Cuisine) {
        triggerHapticFeedback()
        if let index = selectedCuisines.firstIndex(of: cuisine) {
            selectedCuisines.remove(at: index)
        } else {
            selectedCuisines.append(cuisine)
        }
    }
    
    private func filterRecipes() {
        withAnimation(.easeInOut) {
            filteredRecipes = recipes.filter {
                let textMatches = searchText.isEmpty
                || $0.name.localizedCaseInsensitiveContains(searchText)
                || $0.cuisine.id.localizedCaseInsensitiveContains(searchText)
                
                let cuisineMatches = selectedCuisines.isEmpty
                || selectedCuisines.contains($0.cuisine)
                
                return textMatches && cuisineMatches
            }
        }
    }
}
