//
//  RootView.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/6/25.
//

import SwiftUI

struct RootView: View {
    @AppStorage("appearance") private var selectedAppearance: Appearance = .system
    
    var colorScheme: ColorScheme? {
        switch selectedAppearance {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
    var body: some View {
        TabView {
            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "fork.knife")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .onAppear {
            let appearance = UITabBarAppearance()
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        .tint(.primary)
        .preferredColorScheme(colorScheme)
    }
}
