//
//  Cache.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import Foundation

/// An in memory and disk storage cache used to store data for quick access.
actor Cache: CacheProtocol {
    private var memoryCache: [String: Data] = [:]
    private let fileManager: FileManager = .default
    private let diskCacheURL: URL
    private let session: URLSession = URLSession.shared
    
    /// Cache optional initializer.
    /// - Parameter folderName: The folder to store the cached data.
    init?(folderName: String) {
        guard
            let diskCacheURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName)
        else {
            return nil
        }
        
        self.diskCacheURL = diskCacheURL
        
        do {
            if !fileManager.fileExists(atPath: diskCacheURL.path) {
                try fileManager.createDirectory(at: diskCacheURL, withIntermediateDirectories: true)
            }
        } catch {
            print("Failed to create disk cache directory: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// Gets the data that is stored in memory, disk storage, or through a network request.
    /// - Parameter url: The url used to determine where to get the stored data from.
    /// - Returns: A optional Data object for what was stored.
    func get(_ url: URL) async -> Data? {
        let key = url.absoluteString.sha256
        
        if let data = memoryCache[key] {
            return data
        }
        
        let filePath = diskCacheURL.appendingPathComponent(key)
        if let diskData = try? Data(contentsOf: filePath) {
          memoryCache[key] = diskData
          return diskData
        }
        
        do {
            let (data, _) = try await session.data(from: url)
            memoryCache[key] = data
            try data.write(to: filePath)
            return data
        } catch {
            print("Error getting cached data: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    /// Removes the data that is stored in memory then disk storage.
    /// - Parameter url: The url used to determine where to delete the stored data from.
    func delete(_ url: URL) {
        let key = url.absoluteString.sha256
        
        memoryCache.removeValue(forKey: key)
        
        let filePath = diskCacheURL.appendingPathComponent(key)
        do {
            try fileManager.removeItem(at: filePath)
        } catch {
            print("Error removing cached data: \(error.localizedDescription)")
        }
    }
}
