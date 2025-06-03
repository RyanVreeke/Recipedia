//
//  RecipesView.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import SwiftUI

/// View that displays a list of recipies.
struct RecipesView: View {
    @StateObject var viewModel = RecipesViewModel()
    
    init() { }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(1...10, id: \.self) {
                    Text("Recipe \($0)")
                }
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.large)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    RecipesView()
}
