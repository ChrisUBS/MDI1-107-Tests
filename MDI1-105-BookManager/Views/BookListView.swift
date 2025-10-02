//
//  BookListView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 19/09/25.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    
    @AppStorage(SETTINGS_GRID_COLUMNS_KEY) var gridColumns: Int = SETTINGS_GRID_COLUMNS_DEFAULT_VALUE
    @AppStorage(SETTINGS_SHOW_RATING_KEY) var showRating: Bool = SETTINGS_SHOW_RATING_DEFAULT_VALUE
    @AppStorage(SETTINGS_SHOW_LIST_GRID_KEY) var showListGrid: Bool = SETTINGS_SHOW_LIST_GRID_DEFAULT_VALUE
    @Query var books: [PersistentBook]
    @Environment(\.modelContext) private var context
    @State var showEditView: Bool = false
    @State var newBook = PersistentBook()
    @State var isFilteringPresented: Bool = false
    @State var selectedGenre: Genre?
    @State var selectedStatus: ReadingStatus?
    
    // Computed Properties
    private var gridLayout: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: gridColumns)
    }
    private var listBooks: [PersistentBook] {
        books.filter {
            (selectedGenre == nil || $0.genre == selectedGenre)
            && (selectedStatus == nil || $0.status == selectedStatus)
        }
    }
    
    var body: some View {
        NavigationStack {
            if (selectedGenre != nil || selectedStatus != nil) {
                Text("Current filter: \(selectedGenre?.rawValue ?? "All") Genre and \(selectedStatus?.rawValue ?? "All") Status")
            }
            if (showListGrid) {
                ScrollView {
                    LazyVGrid(columns: gridLayout) {
                        ForEach(listBooks, id: \.id) { book in
                            NavigationLink(destination: BookDetailView(book: book)) {
                                SquareCardView(book: book, showRating: showRating)
                            }
                        }
                    }
                }
                .navigationBarTitle("My Books")
                .navigationBarItems(
    //                leading: EditButton(),
                    leading: Button(action: {isFilteringPresented = true}) {
                        // Content of the button
                        Image(systemName: "line.horizontal.3.decrease.circle")
                    },
                    trailing: Button("Add", action: {
                        newBook = PersistentBook()
                        showEditView.toggle()
                    })
                )
                .sheet(isPresented: $showEditView) {
                    AddEditBookView(book: newBook) { savedBook in
                        context.insert(savedBook)
                        try? context.save()
                    }
                }
                .sheet(isPresented: $isFilteringPresented) {
                    FilterView(selectedGenre: $selectedGenre, selectedStatus: $selectedStatus)
                }
            } else {
                List {
                    ForEach(listBooks, id: \.id) { book in
                        NavigationLink(destination: BookDetailView(book: book)) {
                            BookListItemView(book: book, showRating: showRating)
                        }
                    }
                    .onDelete(perform: deleteBooks)
                }
                .navigationBarTitle("My Books")
                .navigationBarItems(
    //                leading: EditButton(),
                    leading: Button(action: {isFilteringPresented = true}) {
                        // Content of the button
                        Image(systemName: "line.horizontal.3.decrease.circle")
                    },
                    trailing: Button("Add", action: {
                        newBook = PersistentBook()
                        showEditView.toggle()
                    })
                )
                .sheet(isPresented: $showEditView) {
                    AddEditBookView(book: newBook) { savedBook in
                        if !books.contains(where: { $0.id == savedBook.id }) {
                            context.insert(savedBook)
                            try? context.save()
                        }
                    }
                }
                .sheet(isPresented: $isFilteringPresented) {
                    FilterView(selectedGenre: $selectedGenre, selectedStatus: $selectedStatus)
                }
            }
        }
    }
    
    private func deleteBooks(at offsets: IndexSet) {
        for index in offsets {
            context.delete(listBooks[index])
        }
        try? context.save()
    }
}
