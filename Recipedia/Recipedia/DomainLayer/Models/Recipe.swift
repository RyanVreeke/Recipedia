//
//  Recipe.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import SwiftUI

/// Represents a recipe that will be displayed to the user where further cooking instructions and videos can be viewed.
struct Recipe: Identifiable, Hashable, Sendable {
    let id: UUID
    let name: String
    let cuisine: Cuisine
    let smallImageURL: URL?
    let largeImageURL: URL?
    let sourceURL: URL?
    let videoURL: URL?
    
    /// Recipe initializer.
    /// - Parameters:
    ///   - id: The unique identifier for a recipe.
    ///   - name: The name of the recipe.
    ///   - cuisine: The type of cuisine for the recipe.
    ///   - smallImageURL: The small image URL for the recipe.
    ///   - largeImageURL: The large image URL for the recipe.
    ///   - sourceURL: The source / instructions URL for the recipe.
    ///   - videoURL: The video / youtube URL for the recipe.
    init(
        id: UUID,
        name: String,
        cuisine: Cuisine,
        smallImageURL: URL?,
        largeImageURL: URL?,
        sourceURL: URL?,
        videoURL: URL?
    ) {
        self.id = id
        self.name = name
        self.cuisine = cuisine
        self.smallImageURL = smallImageURL
        self.largeImageURL = largeImageURL
        self.sourceURL = sourceURL
        self.videoURL = videoURL
    }
}

extension Recipe {
    static func buildAmericanRecipeMock() -> Self {
        return Recipe(
            id: UUID(uuidString: "f8b20884-1e54-4e72-a417-dabbc8d91f12")!,
            name: "Banana Pancakes",
            cuisine: .american,
            smallImageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg"),
            largeImageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg"),
            sourceURL: URL(string: "https://www.bbcgoodfood.com/recipes/banana-pancakes"),
            videoURL: URL(string: "https://www.youtube.com/watch?v=kSKtb2Sv-_U")
        )
    }
    
    static func buildMalaysianRecipeMock() -> Self {
        return Recipe(
            id: UUID(uuidString: "0c6ca6e7-e32a-4053-b824-1dbf749910d8")!,
            name: "Apam Balik",
            cuisine: .other("Malaysian"),
            smallImageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
            largeImageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
            sourceURL: URL(string: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ"),
            videoURL: URL(string: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
        )
    }
    
    static func buildRecipesMock() -> [Self] {
        return [
            Recipe(
                id: UUID(uuidString: "f8b20884-1e54-4e72-a417-dabbc8d91f12")!,
                name: "Banana Pancakes",
                cuisine: .american,
                smallImageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg"),
                largeImageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg"),
                sourceURL: URL(string: "https://www.bbcgoodfood.com/recipes/banana-pancakes"),
                videoURL: URL(string: "https://www.youtube.com/watch?v=kSKtb2Sv-_U")
            ),
            Recipe(
                id: UUID(uuidString: "0c6ca6e7-e32a-4053-b824-1dbf749910d8")!,
                name: "Apam Balik",
                cuisine: .other("Malaysian"),
                smallImageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
                largeImageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
                sourceURL: URL(string: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ"),
                videoURL: URL(string: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
            ),
            Recipe(
                id: UUID(uuidString: "599344f4-3c5c-4cca-b914-2210e3b3312f")!,
                name: "Apple & Blackberry Crumble",
                cuisine: .british,
                smallImageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg"),
                largeImageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg"),
                sourceURL: URL(string: "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble"),
                videoURL: URL(string: "https://www.youtube.com/watch?v=4vhcOwVBDO4")
            ),
        ]
    }
}
