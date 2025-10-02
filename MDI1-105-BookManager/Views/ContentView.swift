//
//  ContentView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 11/09/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @AppStorage(SETTINGS_THEME_KEY) var theme: Theme = .light
    @AppStorage(SETTINGS_ACCENT_COLOR_KEY) var accentTintColor: Color = SETTINGS_ACCENT_COLOR_DEFAULT_VALUE
    
    // Computed Property
    var colorScheme: ColorScheme? {
        switch(theme) {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
    
    var body: some View {
        TabView {
            BookListView()
            .tabItem {
                Label("Books", systemImage: "books.vertical.fill")
            }
            FavoritesView()
                .tabItem{
                    Label("Favorites", systemImage: "heart.fill")
                }
            ImageViewer()
                .tabItem {
                    Label("Images", systemImage: "photo")
                }
            SettingsView()
                .tabItem{
                    Label("Settings", systemImage: "gear")
                }
        }
        .tint(accentTintColor)
        .preferredColorScheme(colorScheme)
    }
}

#Preview {
    ContentView()
}

// jorge.marin@sdgku.edu
// Inbox in Canvas
