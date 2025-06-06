//
//  PillButtonStyle.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/4/25.
//

import SwiftUI

struct PillButtonStyle: ButtonStyle {
    let color: UIColor

    init(color: UIColor) {
        self.color = color
    }

    func makeBody(configuration: Configuration) -> some View {
        let backgroundColor = Color(self.color).opacity(0.2)

        configuration.label
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .fontWeight(.semibold)
            .background(configuration.isPressed ? backgroundColor.opacity(0.5) : backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .scaleEffect(configuration.isPressed ? 0.90 : 1.0) // Slight shrink effect when pressed
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
