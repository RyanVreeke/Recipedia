//
//  ErrorView.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/6/25.
//

import SwiftUI

/// An error view to display various error information.
struct ErrorView: View {
    let title: String
    let message: String?
    let icon: Image?
    
    /// ErrorView initializer.
    /// - Parameters:
    ///   - title: The error title to display.
    ///   - message: The optional message to display.
    ///   - icon: The optional icon image to display.
    init(
        title: String,
        message: String? = nil,
        icon: Image? = nil
    ) {
        self.title = title
        self.message = message
        self.icon = icon
    }
    
    var body: some View {
        VStack(spacing: 16) {
            if let icon = icon {
                icon
                    .font(.system(size: 64))
                    .foregroundStyle(.primary)
            }
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            
            if let message = message {
                Text(message)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
        }
        .multilineTextAlignment(.center)
        .cardStyle()
    }
}
