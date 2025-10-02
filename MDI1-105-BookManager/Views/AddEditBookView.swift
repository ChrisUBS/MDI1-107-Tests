//
//  EditBookView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 14/09/25.
//

import SwiftUI
import SwiftData

struct AddEditBookView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var book: PersistentBook
    
    var onSave: (PersistentBook) -> Void
    @State private var cover: UIImage? = nil
    
    let statuses = ["Planned", "Reading", "Finished"]
    
    init(book: PersistentBook, onSave: @escaping (PersistentBook) -> Void) {
        self.book = book
        self.onSave = onSave
        if let data = book.imageData {
            self._cover = State(initialValue: UIImage(data: data))
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Book Cover") {
                    ImageField(image: $cover)
                }
                
                Section("BOOK DETAILS") {
                    TextField("Title", text: $book.title)
                    TextField("Author", text: $book.author)
                    
                    TextField("Year", text: Binding(
                        get: { book.year.map(String.init) ?? "" },
                        set: { book.year = Int($0) }
                    ))
                    .keyboardType(.numberPad)
                    
                    Picker("Genre", selection: $book.genre) {
                        ForEach(Genre.allCases, id: \.self) { genre in
                            Text(genre.displayName)
                        }
                    }
                    
                    Picker("Status", selection: $book.status) {
                        ForEach(ReadingStatus.allCases, id: \.self) { status in
                            Text(status.displayName)
                        }
                    }
                    
                    TextField("Description", text: $book.summary)
                }
                
                Section("MY RATING & REVIEW") {
                    StartRatingView(rating: $book.rating)
                    TextEditor(text: $book.review)
                        .frame(height: 100)
                }
            }
            .navigationTitle(book.title.isEmpty ? "Add a new book" : "Edit book")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let cover {
                            let newImage = UploadedImage(
                                imageName: "image for \(book.title)",
                                imageData: cover.jpegData(compressionQuality: 0.8)
                            )
                            do {
                                modelContext.insert(newImage)
                                try modelContext.save()
                            } catch {
                                print("Failed to save the image: \(error)")
                            }
                            book.imageData = newImage.imageData
                        }
                        onSave(book)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
