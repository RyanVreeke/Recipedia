//
//  RecipeServiceProtocol.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import Foundation

/// Recipe service protocol that is set up for the RecipeServer and tests.
protocol RecipeServiceProtocol {
    var urlSession: URLSession { get }
    func getRecipes() async throws -> [Recipe]
}
