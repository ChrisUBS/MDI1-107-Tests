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
    @StateObject private var viewModel: AddEditViewModel
    
//    @Bindable var book: PersistentBook
    
//    var onSave: (PersistentBook) -> Void
    @State private var cover: UIImage? = nil
    
    let statuses = ["Planned", "Reading", "Finished"]
    
//    init(book: PersistentBook, onSave: @escaping (PersistentBook) -> Void) {
//        self.book = book
//        self.onSave = onSave
//        if let data = book.imageData {
//            self._cover = State(initialValue: UIImage(data: data))
//        }
//    }
    init(book: PersistentBook? = nil, modelContext: ModelContext) {
        _viewModel = StateObject(
            wrappedValue: AddEditViewModel(
                book: book,
                modelContext: modelContext
            )
        )
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Book Cover") {
                    ImageField(image: $viewModel.cover)
                }
                
                Section("BOOK DETAILS") {
                    TextField("Title", text: $viewModel.title)
                    TextField("Author", text: $viewModel.author)
                    
//                    TextField("Year", text: Binding(
//                        get: { viewModel.year.map(String.init) ?? "" },
//                        set: { viewModel.year = Int($0) }
//                    ))
//                    .keyboardType(.numberPad)
                    
                    Picker("Genre", selection: $viewModel.genre) {
                        ForEach(Genre.allCases, id: \.self) { genre in
                            Text(genre.displayName)
                        }
                    }
                    
                    Picker("Status", selection: $viewModel.status) {
                        ForEach(ReadingStatus.allCases, id: \.self) { status in
                            Text(status.displayName)
                        }
                    }
                    
                    TextField("Description", text: $viewModel.summary)
                }
                
                Section("MY RATING & REVIEW") {
                    StartRatingView(rating: $viewModel.rating)
                    TextEditor(text: $viewModel.review)
                        .frame(height: 100)
                }
            }
            .navigationTitle(viewModel.title.isEmpty ? "Add a new book" : "Edit book")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.save()
//                        if let cover {
//                            let newImage = UploadedImage(
//                                imageName: "image for \(viewModel.title)",
//                                imageData: cover.jpegData(compressionQuality: 0.8)
//                            )
//                            do {
//                                modelContext.insert(newImage)
//                                try modelContext.save()
//                            } catch {
//                                print("Failed to save the image: \(error)")
//                            }
//                            viewModel.imageData = newImage.imageData
//                        }
//                        onSave(viewModel)
                        dismiss()
                    }
                    .disabled(viewModel.isSaveButtonDisabled)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
