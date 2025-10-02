//
//  MDI1_105_BookManagerApp.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 11/09/25.
//

import SwiftUI
import SwiftData

@main
struct MDI1_105_BookManagerApp: App {
    let modelContainer: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
    }
    
    init() {
        do {
            modelContainer = try ModelContainer(for: UploadedImage.self, PersistentBook.self)
        } catch {
            fatalError("Failed to load model container")
        }
    }
}
