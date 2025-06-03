//
//  RecipeJson.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import Foundation

/// The RecipeJson struct is used to decode the recipe json response and map to the Recipe model.
struct RecipeJson: Decodable {
    let uuid: UUID
    let name: String
    let cuisine: String
    let photoURLSmall: URL?
    let photoURLLarge: URL?
    let sourceURL: URL?
    let youtubeURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case cuisine
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
    
    /// Decoder initializer for a RecipeJson object which will correctly decode the properties.
    /// - Parameter decoder: Decoder used to decode the RecipeJson object.
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try container.decode(UUID.self, forKey: .uuid)
        self.name = try container.decode(String.self, forKey: .name)
        self.cuisine = try container.decode(String.self, forKey: .cuisine)
        self.photoURLSmall = try container.decodeIfPresent(URL.self, forKey: .photoURLSmall)
        self.photoURLLarge = try container.decodeIfPresent(URL.self, forKey: .photoURLLarge)
        self.sourceURL = try container.decodeIfPresent(URL.self, forKey: .sourceURL)
        self.youtubeURL = try container.decodeIfPresent(URL.self, forKey: .youtubeURL)
    }
    
    /// Maps the RecipeJson object to a Recipe pretty model.
    /// - Returns: A Recipe object to be used in the application.
    func toModel() -> Recipe {
        Recipe(
            id: uuid,
            name: name,
            cuisine: Cuisine.from(cuisine),
            smallImageURL: photoURLSmall,
            largeImageURL: photoURLLarge,
            sourceURL: sourceURL,
            videoURL: youtubeURL
        )
    }
    
    
    /// A Response struct used to decode the recipes array.
    struct Response: Decodable {
        let recipes: [RecipeJson]
    }
}
