//
//  RecipeServiceMock.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/4/25.
//

import Foundation

final class RecipeServiceMock: RecipeServiceProtocol {
    private let mockRecipes: [Recipe]
    private let mockError: Error?
    
    var urlSession: URLSession
    
    init(mockRecipes: [Recipe], mockError: Error? = nil) {
        self.mockRecipes = mockRecipes
        self.mockError = mockError
        
        let urlSessionConfiguration = URLSessionConfiguration.ephemeral
        urlSessionConfiguration.protocolClasses = [URLMockProtocol.self]
        self.urlSession = URLSession(configuration: urlSessionConfiguration)
    }
    
    func getRecipes() async throws -> [Recipe] {
        if let error = mockError {
            throw error
        }
        
        return mockRecipes
    }
}
