//
//  Cache.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import Foundation

/// An in memory and disk storage cache used to store data for quick access.
actor Cache: CacheProtocol {
    private let fileManager: FileManager = .default
    private let diskCacheURL: URL
    
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
    /// - Parameter key: The key used to determine where to get the stored data from.
    /// - Returns: A optional Data object for what was stored.
    func get(_ key: String) -> Data? {
        var data: Data? = nil
        
        let filePath = diskCacheURL.appendingPathComponent(key)
        if let diskData = try? Data(contentsOf: filePath) {
            data = diskData
        }
        
        return data
    }
    
    /// Sets the data to stored memory and disk storage.
    /// - Parameters:
    ///   - key: The key used to determine where to set the data to be stored.
    ///   - data: The data that will be stored in memory and on disk.
    func set(_ key: String, data: Data) {
        let filePath = diskCacheURL.appendingPathComponent(key)
        do {
            try data.write(to: filePath)
        } catch {
            print("Error setting cached data: \(error.localizedDescription)")
        }
    }
    
    /// Removes the data that is stored in memory then disk storage.
    /// - Parameter key: The key used to determine where to delete the stored data from.
    func delete(_ key: String) {
        let filePath = diskCacheURL.appendingPathComponent(key)
        do {
            try fileManager.removeItem(at: filePath)
        } catch {
            print("Error removing cached data: \(error.localizedDescription)")
        }
    }
    
    /// Clears the in memory and disk storage cached data.
    func clear() {
        let files = (try? fileManager.contentsOfDirectory(at: diskCacheURL, includingPropertiesForKeys: nil)) ?? []
        for file in files {
            try? fileManager.removeItem(at: file)
        }
    }
}
