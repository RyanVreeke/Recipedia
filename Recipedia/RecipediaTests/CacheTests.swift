//
//  CacheTests.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/4/25.
//

import Foundation
import Testing
@testable import Recipedia

@Suite("Cache Tests", .serialized)
final class CacheTests {
    private let cache: CacheProtocol
    private let fileManager: FileManager = .default
    private let diskCacheURL: URL
    
    init() {
        // Initialize the disk space and Cache object used to test before each test.
        diskCacheURL = (fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent("Tests"))!
        cache = Cache(folderName: "Tests")!
    }
    
    deinit {
        // Remove the disk space after each test finishes.
        do {
            if !fileManager.fileExists(atPath: diskCacheURL.path) {
                try fileManager.createDirectory(at: diskCacheURL, withIntermediateDirectories: true)
            }
        } catch {
            print("Failed to create disk cache directory: \(error.localizedDescription)")
        }
    }
    
    @Test("Get In Cache")
    func testGetInCache() async {
        let key = "https://images.com/photos/id/small.jpg".sha256
        let data = Data("Data1".utf8)
        
        let filePath = diskCacheURL.appendingPathComponent(key)
        do {
            try data.write(to: filePath)
        } catch {
            Issue.record("Failed to set data in the cache.")
        }
        
        let value = await cache.get(key)
        
        #expect(value == data)
    }
    
    @Test("Set In Cache")
    func testSetInCache() async {
        let key = "https://images.com/photos/id/small.jpg".sha256
        let data = Data("Data2".utf8)
        
        await cache.set(key, data: data)
        
        let filePath = diskCacheURL.appendingPathComponent(key)
        if let value = try? Data(contentsOf: filePath) {
            #expect(value == data)
        } else {
            Issue.record("Failed to get data in the cache.")
        }
    }
    
    @Test("Delete In Cache")
    func testDeleteInCache() async {
        let key = "https://images.com/photos/id/small.jpg".sha256
        let data = Data("Data3".utf8)
        
        let filePath = diskCacheURL.appendingPathComponent(key)
        do {
            try data.write(to: filePath)
        } catch {
            Issue.record("Failed to set data in the cache.")
        }
        
        if let value = try? Data(contentsOf: filePath) {
            #expect(value == data)
        } else {
            Issue.record("Failed to get data in the cache.")
        }
        
        await cache.delete(key)
        
        let value = try? Data(contentsOf: filePath)
        
        #expect(value == nil)
    }
    
    @Test("Clear Cache")
    func testClearCache() async {
        let firstKey = "https://images.com/photos/id/small.jpg".sha256
        let secondKey = "https://images.com/photos/id/large.jpg".sha256
        let firstData = Data("Data4".utf8)
        let secondData = Data("Dat5".utf8)
        
        let firstFilePath = diskCacheURL.appendingPathComponent(firstKey)
        let secondFilePath = diskCacheURL.appendingPathComponent(secondKey)
        do {
            try firstData.write(to: firstFilePath)
            try secondData.write(to: secondFilePath)
        } catch {
            Issue.record("Failed to set data in the cache.")
        }
        
        if
            let firstValue = try? Data(contentsOf: firstFilePath),
            let secondValue = try? Data(contentsOf: secondFilePath)
        {
            #expect(firstValue == firstData)
            #expect(secondValue == secondData)
        } else {
            Issue.record("Failed to get data in the cache.")
        }
        
        await cache.clear()
        
        let firstValue = try? Data(contentsOf: firstFilePath)
        let secondValue = try? Data(contentsOf: secondFilePath)
        
        #expect(firstValue == nil)
        #expect(secondValue == nil)
    }
}
