//
//  RecipeServiceProtocol.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

/// Recipe service protocol that is set up for the service and tests.
protocol RecipeServiceProtocol {
    func getRecipes() async throws -> [Recipe]
}
