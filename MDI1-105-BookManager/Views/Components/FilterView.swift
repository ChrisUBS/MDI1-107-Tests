//
//  FilterView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 23/09/25.
//

import SwiftUI

struct FilterView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var selectedGenre: Genre?
    @Binding var selectedStatus: ReadingStatus?
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Filter by genre")) {
                    Picker("Genre", selection: $selectedGenre) {
                        Text("All").tag(nil as Genre?)
                        ForEach(Genre.allCases) { genre in
                            Text(genre.displayName).tag(genre)
                        }
                    }
                }
                
                Section(header: Text("Filter by reading status")) {
                    Picker("Status", selection: $selectedStatus) {
                        Text("All").tag(nil as ReadingStatus?)
                        ForEach(ReadingStatus.allCases) { status in
                            Text(status.displayName).tag(status)
                        }
                    }
                }
            }
            .navigationTitle("Filters")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Apply") {
                        dismiss()
                    }
                    .accessibilityLabel(Text("Apply filters"))
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear") {
                        selectedGenre = nil
                        selectedStatus = nil
                        dismiss()
                    }
                    .accessibilityLabel(Text("Clear filters"))
                }
            }

        }
    }
}
