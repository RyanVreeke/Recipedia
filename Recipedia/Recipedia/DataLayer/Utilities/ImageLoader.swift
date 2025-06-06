//
//  ImageLoader.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import SwiftUI

/// ImageLoader utilizes a recipe and a cache in order to load stored images on the disk.
actor ImageLoader<T>: ImageLoaderProtocol {
    private let object: T
    private let cache: CacheProtocol
    
    var urlSession: URLSession
    
    /// ImageLoader initializer.
    /// - Parameters:
    ///   - object: The object used to load different images from.
    ///   - cache: The cache used to retrieve the stored data on the disk.
    init(
        _ object: T,
        cache: CacheProtocol,
        urlSession: URLSession = .shared
    ) {
        self.object = object
        self.cache = cache
        self.urlSession = urlSession
    }
    
    /// Load an image from a cache.
    /// - Parameter url: The url used to determine the stored location of the cached image.
    /// - Returns: An option tuple of a optional UIImage and a Bool to determine if the UIImage was retrieved from the cache or network.
    func loadImage(url: URL) async -> (UIImage?, Bool)? {
        let key = url.absoluteString.sha256
        var image: UIImage? = nil
        var cacheHit = false
        
        if let data = await cache.get(key) {
            image = UIImage(data: data)
            cacheHit = true
        } else {
            do {
                let (data, _) = try await urlSession.data(from: url)
                await cache.set(key, data: data)
                
                image = UIImage(data: data)
            } catch {
                print("Error getting image data: \(error.localizedDescription)")
            }
        }
        
        return (image, cacheHit)
    }
}
