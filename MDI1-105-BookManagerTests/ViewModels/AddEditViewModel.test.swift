//
//  AddEditViewModel.test.swift
//  MDI1-105-BookManagerTests
//
//  Created by Christian Bonilla on 02/10/25.
//

import Testing
import SwiftData
@testable import MDI1_105_BookManager

@MainActor
struct AddEditViewModel_test {

    @Test("ViewModel initilizes correctly for a new book")
    func testNewBookInitialization() throws {
        // phase 1: Arrange
        let container = try ModelContainer(for: PersistentBook.self, configurations: .init(isStoredInMemoryOnly: true))
        let modelContext = container.mainContext
        
        // phase 2:
        let viewModel = AddEditViewModel(book: nil, modelContext: modelContext)
        
        // phase 3:
        #expect(viewModel.title == "")
        #expect(viewModel.author == "")
        // every other field assertions
        #expect(viewModel.navigationTitle == "Add Book")
        #expect(viewModel.isSaveButtonDisabled)
        
    }
    
    @Test("ViewModel initializes correctly for an existing book")
    func testExistingBookInitialization() throws {
        //phase 1: Arrange
        let container = try ModelContainer(for: PersistentBook.self, configurations: .init(isStoredInMemoryOnly: true))
        let modelContext = container.mainContext
        let book = PersistentBook(title: "A New Hope", author: "George Lucas", genre: .fantasy)
        
        // phase 2: Act
        let viewModel = AddEditViewModel(book: book, modelContext: modelContext)
        
        // phase 3: Assert
        #expect(viewModel.navigationTitle == "Edit Book")
        #expect(viewModel.title == "A New Hope")
        #expect(viewModel.author == "George Lucas")
        #expect(viewModel.genre == .fantasy)
        #expect(viewModel.isSaveButtonDisabled)
        
        // Check small changes
        // Act 2
        viewModel.title = " \n"
        #expect(viewModel.isSaveButtonDisabled)
        // Assert 2
        viewModel.title = "A New Hope"
        #expect(viewModel.isSaveButtonDisabled)
        viewModel.title = "A New Hope 2"
        #expect(!viewModel.isSaveButtonDisabled)
    }
    
    @Test("ViewModel creates a new book correctly")
    func testCreateNewBook() throws {
        
    }
    
    @Test("ViewModel updates an existing book correctly")
    func testUpdateExistingBook() throws {
        
    }
    
}
