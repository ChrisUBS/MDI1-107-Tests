//
//  FavoritesView.test.swift
//  MDI1-105-BookManagerTests
//
//  Created by Christian Bonilla on 01/10/25.
//

import Testing
@testable import MDI1_105_BookManager

@MainActor @Suite("Favorite View Tests")
struct FavoritesViewTests {

    @Test("Filter function works correctly")
    func testFilterFunctionWorksCorrectly() async throws {
        // Arrange
        let books = [
            PersistentBook(title: "Book 1", isFavorite: true),
            PersistentBook(title: "Book 2"),
            PersistentBook(title: "Book 3"),
        ]
        
        // Act
        let favoritesBook = filterFavoriteBooks(books: books, selectedGenre: nil, selectedStatus: nil)
        
        // Assert
        #expect(favoritesBook.count == 1)
        #expect(favoritesBook[0].title == "Book 1")
    }

}
