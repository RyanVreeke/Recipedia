//
//  LinkButtonStyle.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/4/25.
//

import SwiftUI

struct LinkButtonStyle: ButtonStyle {
    let backgroundColor: Color

    init(backgroundColor: Color) {
        self.backgroundColor = backgroundColor
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(16)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
