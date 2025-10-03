//
//  AddEditViewModel.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 02/10/25.
//

import SwiftUI
import SwiftData

@MainActor
class AddEditViewModel: ObservableObject {
    
    private var bookToEdit: PersistentBook?
    private let modelContext: ModelContext
    
    @Published var title: String = ""
    @Published var author: String = ""
    @Published var summary: String = ""
    @Published var rating: Int = 0
    @Published var review: String = ""
    @Published var year: Int = 0
    @Published var status: ReadingStatus = .planned
    @Published var genre: Genre = .unkowned
    @Published var isFavorite: Bool = false
    @Published var cover: UIImage? = nil
    
    // Computed properties
    var navigationTitle: String {
        bookToEdit != nil ? "Edit Book" : "Add Book"
    }
    
    var isSaveButtonDisabled: Bool {
        // Debugging
//        let _ = print(title, bookToEdit?.title)
        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || // title == "" || title == nil // ! title == " " %% title == "\n"
        (title == bookToEdit?.title
         && author == bookToEdit?.author
         && summary == bookToEdit?.summary
         && rating == bookToEdit?.rating
         && review == bookToEdit?.review
         && status == bookToEdit?.status
         && genre == bookToEdit?.genre
         && isFavorite == bookToEdit?.isFavorite)
    }
    
    init(book: PersistentBook? = nil, modelContext: ModelContext) {
        self.bookToEdit = book
        self.modelContext = modelContext
        
        // If the book is not nil, then we're editing instead of adding
        if let book {
            self.title = book.title
            self.author = book.author
            self.summary = book.summary
            self.rating = book.rating
            self.review = book.review
            self.year = book.year ?? 0
            self.status = book.status
            self.genre = book.genre
            self.isFavorite = book.isFavorite
            
            if let coverData = book.imageData {
                self.cover = UIImage(data: coverData)
            }
        }
    }
    
    func save() {
        let isANewBook = bookToEdit == nil
        let bookToSave = bookToEdit ?? PersistentBook(title: "")
        bookToSave.title = title
        bookToSave.author = author
        bookToSave.summary = summary
        bookToSave.rating = rating
        bookToSave.review = review
        bookToSave.status = status
        bookToSave.genre = genre
        bookToSave.isFavorite = isFavorite
        if (cover != nil) {
            bookToSave.imageData = cover?.jpegData(compressionQuality: 0.8)
        }
        
        if isANewBook {
            modelContext.insert(bookToSave)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to save the book: \(error)")
        }
        
    }
}
