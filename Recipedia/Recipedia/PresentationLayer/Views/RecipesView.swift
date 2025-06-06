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
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(Cuisine.allCases) { cuisine in
                            Button {
                                viewModel.toggleCuisineSelection(cuisine)
                            } label: {
                                Text(cuisine.description)
                                    .foregroundStyle(.primary)
                            }
                            .buttonStyle(
                                PillButtonStyle(color: viewModel.selectedCuisines.contains(cuisine) ? .blue : .gray)
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                switch viewModel.viewState {
                case .loading:
                    ProgressView()
                        .padding(.all, 16)
                case .empty:
                    ErrorView(
                        title: "No Available Recipes",
                        message: "Check back later for more recipes!"
                    )
                    .padding(.all, 16)
                case .error:
                    ErrorView(
                        title: "Error Retrieving Recipes",
                        message: "Check you network connection and refresh.",
                        icon: Image(systemName: "exclamationmark.triangle.fill")
                    )
                    .padding(.all, 16)
                case .loaded:
                    LazyVGrid(columns: viewModel.columns, spacing: 16) {
                        ForEach(viewModel.filteredRecipes, id: \.self) { recipe in
                            NavigationLink(value: recipe) {
                                RecipeCard(recipe)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.top, 8)
                    .padding([.horizontal, .bottom], 16)
                }
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeView(recipe)
            }
            .refreshable {
                await viewModel.refreshRecipes()
            }
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search recipes or cuisines"
            )
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
