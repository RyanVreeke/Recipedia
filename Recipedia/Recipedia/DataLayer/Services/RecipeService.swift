//
//  RecipeService.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import Foundation

/// A service used to retrieve recipes that will be displayed in the application.
final class RecipeService: RecipeServiceProtocol {
    static let shared: RecipeService = RecipeService()
    
    private let baseURL: String = "https://d3jbb8n5wk0qxi.cloudfront.net"
    private let decoder: JSONDecoder = JSONDecoder()
    
    var urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    /// Gets the recipes from the created endpoint.
    /// - Returns: An array of the retrieved Recipe objects.
    func getRecipes() async throws -> [Recipe] {
        // Commented out endpoints for testing.
        
        // Empty Endpoint
        /*
         let endpoint = Endpoint(
             baseURL: baseURL,
             path: "/recipes-empty.json",
             httpMethod: .get,
             headers: ["Accept" : "application/json"]
         )
        */
        /*
         // Malformed Endpoint
         let endpoint = Endpoint(
             baseURL: baseURL,
             path: "/recipes-malformed.json",
             httpMethod: .get,
             headers: ["Accept" : "application/json"]
         )
         */
        
        let endpoint = Endpoint(
            baseURL: baseURL,
            path: "/recipes.json",
            httpMethod: .get,
            headers: ["Accept": "application/json"]
        )
        
        do {
            let request = try endpoint.urlRequest() // Create the URLRequest based off the created Endpoint.
            
            let (data, response) = try await urlSession.data(for: request)
            
            /*
             Checking for all successful http status codes.
             In the future if the api returns different specific status codes for successes or failures
             we could switch on those status codes and conditionally handle decoding or throwing errors
             so that the app can handle those cases and act on them accordingly.
             TODO: Implement future http response status code cases.
             */
            guard
                let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode)
            else {
                throw URLError(.badServerResponse)
            }
            
            let recipesResponse = try decoder.decode(RecipeJson.Response.self, from: data).recipes
            let recipes = recipesResponse.map { $0.toModel() } // Map the recipes to the pretty model object.
            return recipes
        } catch {
            print("Error getting recipes: \(error.localizedDescription)")
            throw error
        }
    }
}
