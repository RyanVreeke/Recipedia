//
//  View+cardStyle.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/3/25.
//

import SwiftUI

private struct CardStyleModifier: ViewModifier {
    let edgeInsets: EdgeInsets
    
    func body(content: Content) -> some View {
        content
            .padding(edgeInsets)
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(16)
    }
}

extension View {
    func cardStyle(
        edgeInsets: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    ) -> some View {
        modifier(CardStyleModifier(edgeInsets: edgeInsets))
    }
}
