//
//  CacheProtocol.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import Foundation

/// Cache protocol that is set up for a Cache and tests.
protocol CacheProtocol: Actor {
    func get(_ url: URL) async -> Data?
    func delete(_ url: URL) async
}
