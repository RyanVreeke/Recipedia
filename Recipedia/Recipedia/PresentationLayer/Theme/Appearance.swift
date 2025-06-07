//
//  Appearance.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/6/25.
//

enum Appearance: String, CaseIterable, Identifiable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"
    
    var id: String { self.rawValue }
}
