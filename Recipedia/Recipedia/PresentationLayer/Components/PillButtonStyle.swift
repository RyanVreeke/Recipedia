//
//  PillButtonStyle.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/4/25.
//

import SwiftUI

struct PillButtonStyle: ButtonStyle {
    let color: UIColor
    let isCircle: Bool

    init(color: UIColor, isCircle: Bool = false) {
        self.color = color
        self.isCircle = isCircle
    }

    func makeBody(configuration: Configuration) -> some View {
        let backgroundColor = Color(self.color).opacity(0.2)

        configuration.label
            .padding(.vertical, 8)
            .padding(.horizontal, self.isCircle ? 8 : 12)
            .fontWeight(.semibold)
            .background(configuration.isPressed ? backgroundColor.opacity(0.1) : backgroundColor)
            .foregroundColor(Color(self.color))
            .clipShape(self.isCircle ? AnyShape(Circle()) : AnyShape(RoundedRectangle(cornerRadius: 20)))
            .scaleEffect(configuration.isPressed ? 0.90 : 1.0) // Slight shrink effect when pressed
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
