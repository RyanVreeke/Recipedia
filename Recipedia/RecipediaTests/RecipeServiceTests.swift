//
//  RecipeServiceTests.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/5/25.
//

import Foundation
import Testing
@testable import Recipedia

@Suite("Recipe Service Tests", .serialized)
final class RecipeServiceTests {

    init() { }
    
    func buildRecipeService() -> RecipeService {
        let urlSessionConfiguration = URLSessionConfiguration.ephemeral
        urlSessionConfiguration.protocolClasses = [URLMockProtocol.self]
        
        let urlSessionMock = URLSession(configuration: urlSessionConfiguration)
        return RecipeService(urlSession: urlSessionMock)
    }
    
    @Test("Get Recipes Success")
    func testGetRecipesSuccess() async throws {
        let response = RecipeJson.buildRecipesMock()
        let data = response.data(using: .utf8)!
        
        URLMockProtocol.error = nil
        URLMockProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Accept": "application/json"]
            )!
            return (response, data)
        }
        
        let recipeService = buildRecipeService()
        
        do {
            let recipes = try await recipeService.getRecipes()
            
            #expect(recipes.count == 3)
            #expect(recipes.first?.id == UUID(uuidString: "f8b20884-1e54-4e72-a417-dabbc8d91f12"))
            #expect(recipes.first?.name == "Banana Pancakes")
            #expect(recipes.first?.cuisine == .american)
            #expect(recipes.first?.smallImageURL == URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg"))
            #expect(recipes.first?.largeImageURL == URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg"))
            #expect(recipes.first?.sourceURL == URL(string: "https://www.bbcgoodfood.com/recipes/banana-pancakes"))
            #expect(recipes.first?.videoURL == URL(string: "https://www.youtube.com/watch?v=kSKtb2Sv-_U"))
        } catch {
            Issue.record("Failed to get recipes: \(error.localizedDescription)")
        }
    }
    
    @Test("Get Recipes Empty")
    func testGetRecipesEmpty() async throws {
        let response = RecipeJson.buildRecipesEmptyMock()
        let data = response.data(using: .utf8)!
        
        URLMockProtocol.error = nil
        URLMockProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!,
                statusCode: 204,
                httpVersion: nil,
                headerFields: ["Accept": "application/json"]
            )!
            return (response, data)
        }
        
        let recipeService = buildRecipeService()
        
        do {
            let recipes = try await recipeService.getRecipes()
            
            #expect(recipes.count == 0)
        } catch {
            Issue.record("Failed to get empty recipes: \(error.localizedDescription)")
        }
    }
    
    @Test("Get Recipes Endpoint Bad URL Error")
    func testGetRecipesBadURLError() async throws {
        let endpointMock = Endpoint.buildInvalidURLGetEndpointMock()
        
        #expect(throws: URLError(.badURL), "Expected URLError badURL to be thrown.") {
            _ = try endpointMock.urlRequest()
        }
    }
    
    @Test("Get Recipes Bad Server Response")
    func testGetRecipesBadServerResponse() async throws {
        let recipesJson = RecipeJson.buildRecipesMock()
        let data = recipesJson.data(using: .utf8)!
        
        URLMockProtocol.error = nil
        URLMockProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!,
                statusCode: 400,
                httpVersion: nil,
                headerFields: ["Accept": "application/json"]
            )!
            return (response, data)
        }
        
        let recipeService = buildRecipeService()
        
        await #expect(throws: URLError(.badServerResponse), "Expected URLError badServerResponse to be thrown.") {
            try await recipeService.getRecipes()
        }
    }
    
    @Test("Get Recipes Decoding Error")
    func testGetRecipesDecodingError() async throws {
        let response = RecipeJson.buildRecipesMalformedMock()
        let data = response.data(using: .utf8)!
        
        let decodingErrorContext = DecodingError.Context(codingPath: [], debugDescription: "The JSON data could not be decoded.")
        URLMockProtocol.error = DecodingError.dataCorrupted(decodingErrorContext)
        URLMockProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Accept": "application/json"]
            )!
            return (response, data)
        }
        
        let recipeService = buildRecipeService()
        
        await #expect(throws: Error.self, "Expected error to be thrown.") {
            _ = try await recipeService.getRecipes()
        }
    }
}
