//
//  Cuisine.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import SwiftUI

/// Enum Cuisine is used to display recipe cuisine information and filter recipes.
enum Cuisine: Identifiable, Hashable, CustomStringConvertible, Equatable, CaseIterable {
    case american
    case british
    case canadian
    case french
    case greek
    case italian
    case other(String)
    
    var id: String {
        switch self {
        case .american:
            return "American"
        case .british:
            return "British"
        case .canadian:
            return "Canadian"
        case .french:
            return "French"
        case .greek:
            return "Greek"
        case .italian:
            return "Italian"
        case .other(let name):
            return name
        }
    }
    
    var flag: String {
        switch self {
        case .american:
            return "🇺🇸"
        case .british:
            return "🇬🇧"
        case .canadian:
            return "🇨🇦"
        case .french:
            return "🇫🇷"
        case .greek:
            return "🇬🇷"
        case .italian:
            return "🇮🇹"
        case .other:
            return "🌎"
        }
    }
    
    var description: String {
        return "\(self.id) \(self.flag)"
    }
    
    static func ==(lhs: Cuisine, rhs: Cuisine) -> Bool {
        switch (lhs, rhs) {
        case (.american, .american),
            (.british, .british),
            (.canadian, .canadian),
            (.french, .french),
            (.greek, .greek),
            (.italian, .italian),
            (.other, .other):
            return true
        default:
            return false
        }
    }
    
    static var allCases: [Cuisine] {
        return [
            .american,
            .british,
            .canadian,
            .french,
            .greek,
            .italian,
            .other("Other")
        ]
    }
    
    static func from(_ string: String) -> Cuisine {
        let normalizedString = string.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        switch normalizedString {
        case "american":
            return .american
        case "british":
            return .british
        case "canadian":
            return .canadian
        case "french":
            return .french
        case "greek":
            return .greek
        case "italian":
            return .italian
        default:
            return .other(normalizedString.capitalized)
        }
    }
}
