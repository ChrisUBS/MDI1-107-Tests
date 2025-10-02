//
//  SettingsView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 25/09/25.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage(SETTINGS_THEME_KEY) var currentTheme: Theme = .light
    @AppStorage(SETTINGS_GRID_COLUMNS_KEY) var gridColumns: Int = SETTINGS_GRID_COLUMNS_DEFAULT_VALUE
    @AppStorage(SETTINGS_ACCENT_COLOR_KEY) var accentTintColor: Color = SETTINGS_ACCENT_COLOR_DEFAULT_VALUE
    @AppStorage(SETTINGS_SHOW_RATING_KEY) var showRating: Bool = SETTINGS_SHOW_RATING_DEFAULT_VALUE
    @AppStorage(SETTINGS_SHOW_LIST_GRID_KEY) var showListGrid: Bool = SETTINGS_SHOW_LIST_GRID_DEFAULT_VALUE
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Appearance")) {
                    Picker("Theme", selection: $currentTheme) {
                        ForEach(Theme.allCases, id:\.self) { theme in
                            Text(theme.rawValue.capitalized).tag(theme)
                        }
                    }
                    
                    ColorPicker("Accent Color", selection: $accentTintColor)
                }
                
                Section(header: Text("Grid")) {
                    Stepper("Colums: \(gridColumns)", value: $gridColumns, in: 2...4)
                }
                
                Section(header: Text("List Settings")) {
                    Toggle(isOn: $showRating) {
                        Text("Show Rating")
                    }
                    
                    Toggle(isOn: $showListGrid) {
                        Text("Show List as Grid")
                    }
                }
            }
        }
    }
}
