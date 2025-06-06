//
//  ImageLoaderTests.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/5/25.
//

import SwiftUI
import Testing
@testable import Recipedia

@Suite("ImageLoader Tests", .serialized)
final class ImageLoaderTests {
    
    init() { }

    /// Helper function to build the ImageLoader<Recipe> that will be tested.
    /// - Parameters:
    ///   - recipeMock: The mocked Recipe object.
    ///   - cacheMock: The mocked cache object.
    /// - Returns: The ImageLoader<Recipe> object to be tested.
    func buildRecipeImageLoader(_ recipeMock: Recipe, cacheMock: CacheMock) -> ImageLoader<Recipe> {
        let urlSessionConfiguration = URLSessionConfiguration.ephemeral
        urlSessionConfiguration.protocolClasses = [URLMockProtocol.self]
        
        let urlSessionMock = URLSession(configuration: urlSessionConfiguration)
        return ImageLoader(recipeMock, cache: cacheMock, urlSession: urlSessionMock)
    }
    
    @Test("Test Load Image From Memory")
    func testLoadRecipeImageFromMemory() async {
        let recipeMock = Recipe.buildAmericanRecipeMock()
        let cacheMock = CacheMock()
        let url = recipeMock.smallImageURL!
        let key = url.absoluteString.sha256
        let uiImageMock = UIImage(systemName: "photo")!
        let uiImageMockData = uiImageMock.pngData()!
        
        let recipeImageLoader = buildRecipeImageLoader(recipeMock, cacheMock: cacheMock)
        
        await cacheMock.set(key, data: uiImageMockData)
        
        if let (uiImage, cacheHit) = await recipeImageLoader.loadImage(url: url) {
            #expect(uiImage != nil)
            #expect(cacheHit == true)
        } else {
            Issue.record("Failed to load image from memory.")
        }
    }
    
    @Test("Test Load Image From Network")
    func testLoadRecipeImageFromNetwork() async {
        let recipeMock = Recipe.buildAmericanRecipeMock()
        let cacheMock = CacheMock()
        let url = recipeMock.smallImageURL!
        let key = url.absoluteString.sha256
        let uiImageMock = UIImage(systemName: "photo")!
        let uiImageMockData = uiImageMock.pngData()!
        
        URLMockProtocol.error = nil
        URLMockProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Accept": "application/json"]
            )!
            return (response, uiImageMockData)
        }
        
        let recipeImageLoader = buildRecipeImageLoader(recipeMock, cacheMock: cacheMock)
        
        if let (uiImage, cacheHit) = await recipeImageLoader.loadImage(url: url) {
            #expect(uiImage != nil)
            #expect(cacheHit == false)
            await #expect(cacheMock.get(key) != nil)
        } else {
            Issue.record("Failed to load image from the network.")
        }
    }
    
    @Test("Test Failed to Load Image")
    func testLoadRecipeImageFailed() async {
        let recipeMock = Recipe.buildAmericanRecipeMock()
        let cacheMock = CacheMock()
        let url = recipeMock.smallImageURL!
        let key = url.absoluteString.sha256
        let uiImageMock = UIImage(systemName: "photo")!
        let uiImageMockData = uiImageMock.pngData()!
        
        URLMockProtocol.error = URLError(.networkConnectionLost)
        URLMockProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Accept": "application/json"]
            )!
            return (response, uiImageMockData)
        }
        
        let recipeImageLoader = buildRecipeImageLoader(recipeMock, cacheMock: cacheMock)
        
        if let (uiImage, cacheHit) = await recipeImageLoader.loadImage(url: url) {
            #expect(uiImage == nil)
            #expect(cacheHit == false)
            await #expect(cacheMock.get(key) == nil)
        } else {
            Issue.record("Failed to load image from the network.")
        }
    }
}
