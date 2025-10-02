//
//  FavoritesView.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 19/09/25.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    
    @AppStorage(SETTINGS_GRID_COLUMNS_KEY) var gridColumns: Int = SETTINGS_GRID_COLUMNS_DEFAULT_VALUE
    @AppStorage(SETTINGS_SHOW_RATING_KEY) var showRating: Bool = SETTINGS_SHOW_RATING_DEFAULT_VALUE
    @AppStorage(SETTINGS_SHOW_LIST_GRID_KEY) var showListGrid: Bool = SETTINGS_SHOW_LIST_GRID_DEFAULT_VALUE
    @Query var books: [PersistentBook]
    @State var isFilteringPresented: Bool = false
    @State var selectedGenre: Genre?
    @State var selectedStatus: ReadingStatus?
    
    // Computed Properties
    private var gridLayout: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: gridColumns)
    }
    private var favoriteBooks: [PersistentBook] {
//        books.filter {
//            $0.isFavorite
//            && (selectedGenre == nil || $0.genre == selectedGenre)
//            && (selectedStatus == nil || $0.status == selectedStatus)
//        }
        filterFavoriteBooks(books: books, selectedGenre: selectedGenre, selectedStatus: selectedStatus)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if (selectedGenre != nil || selectedStatus != nil) {
                    Text("Current filter: \(selectedGenre?.rawValue ?? "All") Genre and \(selectedStatus?.rawValue ?? "All") Status")
                }
                LazyVGrid(columns: gridLayout) {
                    ForEach(favoriteBooks, id: \.self.id) { book in
                        NavigationLink(destination: BookDetailView(book: book)) {
                            SquareCardView(book: book, showRating: showRating)
                        }
                    }
                }
            }
            .navigationBarTitle("My Favorite Books")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {isFilteringPresented = true}) {
                        // Content of the button
                        Image(systemName: "line.horizontal.3.decrease.circle")
                    }
                    .accessibilityLabel("Open filter options")
                }
            }
            .sheet(isPresented: $isFilteringPresented) {
                FilterView(selectedGenre: $selectedGenre, selectedStatus: $selectedStatus)
            }
        }
    }
}

func filterFavoriteBooks(books: [PersistentBook], selectedGenre: Genre?, selectedStatus: ReadingStatus?) -> [PersistentBook] {
    return books.filter {
        //$0 = one book in books
        $0.isFavorite
        && (selectedGenre == nil || $0.genre == selectedGenre)
        && (selectedStatus == nil || $0.status == selectedStatus)
    }
}
