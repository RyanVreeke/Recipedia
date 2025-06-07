//
//  SettingsView.swift
//  Recipedia
//
//  Created by Ryan Vreeke on 6/6/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("appearance") private var selectedAppearance: Appearance = .system
    
    var body: some View {
        List {
            Section(header: Text("Display")) {
                Picker("Appearance", selection: $selectedAppearance){
                    ForEach(Appearance.allCases) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
            }
        }
    }
}
