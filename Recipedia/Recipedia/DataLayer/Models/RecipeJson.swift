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
    
    static func buildRecipesMock() -> String {
        return
            """
            {
                "recipes": [
                    {
                        "cuisine": "American",
                        "name": "Banana Pancakes",
                        "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg",
                        "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg",
                        "source_url": "https://www.bbcgoodfood.com/recipes/banana-pancakes",
                        "uuid": "f8b20884-1e54-4e72-a417-dabbc8d91f12",
                        "youtube_url": "https://www.youtube.com/watch?v=kSKtb2Sv-_U"
                    },
                    {
                        "cuisine": "Malaysian",
                        "name": "Apam Balik",
                        "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                        "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                        "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                        "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                        "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
                    },
                    {
                        "cuisine": "British",
                        "name": "Apple & Blackberry Crumble",
                        "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                        "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
                        "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
                        "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
                        "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
                    },
                ]
            }
            """
    }
    
    static func buildRecipesEmptyMock() -> String {
        return
            """
            {
                "recipes": []
            }
            """
    }
    
    static func buildRecipesMalformedMock() -> String {
        return
            """
            {
                "recipes": [
                    {
                        "cuisine": "American",
                        "name": "Banana Pancakes",
                        "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg",
                        "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg",
                        "source_url": "https://www.bbcgoodfood.com/recipes/banana-pancakes",
                        "uuid": "f8b20884-1e54-4e72-a417-dabbc8d91f12",
                        "youtube_url": "https://www.youtube.com/watch?v=kSKtb2Sv-_U"
                    },
                    {
                        "cuisine": "Malaysian",
                        "name": "Apam Balik",
                        "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                        "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                        "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                        "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                        "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
                    },
                    {
                        "cuisine": "British",
                        "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                        "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
                        "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
                        "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
                        "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
                    },
                ]
            """
    }
}
