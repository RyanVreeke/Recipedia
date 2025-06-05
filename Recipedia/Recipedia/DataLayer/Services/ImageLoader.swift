//
//  ImageLoader.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import Foundation
import SwiftUI

/// ImageLoader utilizes a recipe and a cache in order to load stored images on the disk.
@MainActor
final class ImageLoader<T>: ImageLoaderProtocol {
    private let object: T
    private let cache: CacheProtocol
    private let session: URLSession = URLSession.shared
    
    /// ImageLoader initializer.
    /// - Parameters:
    ///   - object: The object used to load different images from.
    ///   - cache: The cache used to retrieve the stored data on the disk.
    init(
        _ object: T,
        cache: CacheProtocol
    ) {
        self.object = object
        self.cache = cache
    }
    
    /// Load an image from a cache.
    /// - Parameter url: The url used to determine the stored location of the cached image.
    /// - Returns: An optional UIImage if it exists in the cache.
    func loadImage(url: URL) async -> UIImage? {
        let key = url.absoluteString.sha256
        var image: UIImage? = nil
        
        if let data = await cache.get(key) {
            image = UIImage(data: data)
        } else {
            do {
                let (data, _) = try await session.data(from: url)
                await cache.set(key, data: data)
                
                image = UIImage(data: data)
            } catch {
                print("Error getting image data: \(error.localizedDescription)")
            }
        }
        
        return image
    }
}
