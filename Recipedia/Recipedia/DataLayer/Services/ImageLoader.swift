//
//  ImageLoader.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import Foundation
import SwiftUI

/// ImageLoader utilizes a recipe and a cache in order to load stored images on the disk.
final class ImageLoader<T>: ImageLoaderProtocol {
    private let object: T
    private let cache: CacheProtocol
    
    /// ImageLoader initializer.
    /// - Parameters:
    ///   - recipe: The recipe used to provide different image URL's.
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
        guard
            let data = await cache.get(url)
        else {
            return nil
        }
        
        return UIImage(data: data)
    }
}
