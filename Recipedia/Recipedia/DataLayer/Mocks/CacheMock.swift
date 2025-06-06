//
//  CacheMock.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/4/25.
//

import Foundation

actor CacheMock: CacheProtocol {
    private var memoryCacheMock: [String: Data] = [:]
    
    init() { }
    
    func get(_ key: String) -> Data? {
        return memoryCacheMock[key]
    }
    
    func set(_ key: String, data: Data) {
        memoryCacheMock[key] = data
    }
    
    func delete(_ key: String) {
        memoryCacheMock.removeValue(forKey: key)
    }
    
    func clear() {
        memoryCacheMock = [:]
    }
}
