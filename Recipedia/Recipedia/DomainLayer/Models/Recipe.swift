//
//  Recipe.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import SwiftUI

/// Represents a recipe that will be displayed to the user where further cooking instructions and videos can be viewed.
struct Recipe: Identifiable, Hashable {
    let id: UUID
    let name: String
    let cuisine: String
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
        cuisine: String,
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
