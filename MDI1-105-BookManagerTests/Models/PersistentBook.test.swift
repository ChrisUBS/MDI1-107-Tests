//
//  PersistentBook.test.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 02/10/25.
//

import Testing
@testable import MDI1_105_BookManager

@MainActor @Suite("PersistentBook Tests")
struct PersistentBookTests {
    
    @Test("Book Initialization")
    func testBookInitialization() async throws{
        let book = PersistentBook(title: "Test Title",
                                  author: "John Doe",
                                  year: 2025,
                                  category: "Programming",
                                  rating: 4,
                                  review: "Great book!",
                                  status: .reading,
                                  genre: .fantasy,
                                  isFavorite: true)
        
        #expect(book.title == "Test Title")
        #expect(book.author == "John Doe")
        #expect(book.rating == 4)
        #expect(book.isFavorite == true)
        
        // Professor's example
        // Arrange
        let bookTitle = "Test Title"
        let status = ReadingStatus.reading
        let author = "Test Author"
        let isFavorite = true
        
        // Act
        let bookTest = PersistentBook(title: bookTitle)
        
        // Assert
        #expect(bookTest.title == bookTitle)
        
        // Act II
        bookTest.status = status
        bookTest.author = author
        bookTest.isFavorite = isFavorite
        
        // Assert II
        #expect(bookTest.status == status)
        #expect(bookTest.author == author)
        #expect(bookTest.isFavorite == isFavorite)
        
        #expect(bookTest.getNameAndAuthor() == "Test Title - Test Author")
    }
    
    @Test("Book Modification")
    func testBookModification() async throws{
        var book = PersistentBook(title: "Old Title", rating: 2)
        book.title = "New Title"
        book.rating = 5
        book.isFavorite = true
        
        #expect(book.title == "New Title")
        #expect(book.rating == 5)
        #expect(book.isFavorite == true)
    }
    
    @Test("Book Filtering")
    func testBookFilteringByGenreAndStatus() async throws{
        let books = [
            PersistentBook(title: "Book 1", status: .reading, genre: .fantasy),
            PersistentBook(title: "Book 2", status: .planned, genre: .unkowned),
            PersistentBook(title: "Book 3", status: .planned, genre: .fantasy)
        ]
        
        // Simalate BookListView
        let selectedGenre: Genre? = .fantasy
        let selectedStatus: ReadingStatus? = .planned
        
        let filteredBooks = books.filter {
            (selectedGenre == nil || $0.genre == selectedGenre) &&
            (selectedStatus == nil || $0.status == selectedStatus)
        }
        
        #expect(filteredBooks.count == 1)
        #expect(filteredBooks.first?.title == "Book 3")
    }
}
