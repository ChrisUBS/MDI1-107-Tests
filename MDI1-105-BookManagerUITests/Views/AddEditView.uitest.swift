//
//  AddEditView.uitest.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 07/10/25.
//

import XCTest

class AddEditViewUITests: XCTestCase {
    func testAddBookWorks() throws {
        // MARK: - Arrange: Launch the App and Get Initial State
        let app = XCUIApplication()
        app.launch() // Launch the application before running the test
        
        // Get the current number of books displayed in the collection view
        let currentBookCount = app.collectionViews.firstMatch.cells.count
        
        // MARK: - Act: Simulate User Input
        let addBookButton = app.buttons["Add"]
        addBookButton.tap() // Simulate tapping the "Add" button to open the add book screen
        
        // Verify that the Save button is initially disabled (no title entered yet)
        XCTAssertTrue(!app.buttons["Save"].isEnabled)
        
        // Access the "Title" text field and simulate typing a new title
        let titleTextField = app.textFields["Title"]
        titleTextField.tap()
        titleTextField.typeText("New book #\(currentBookCount + 1)")
        
        // Tap the "Save" button to add the new book
        app.buttons["Save"].tap()
        
        // MARK: - Assert: Verify the Outcome
        
        // Check that the total number of cells increased (a new book was added)
        XCTAssertTrue(app.collectionViews.firstMatch.cells.count > currentBookCount)
        
        // Verify the count increased exactly by one
        XCTAssertEqual(app.collectionViews.firstMatch.cells.count, currentBookCount + 1)
        
        // Access the last added cell and check that its title matches the expected value
        let lastBookTitle = app.collectionViews.firstMatch.cells.element(boundBy: currentBookCount).staticTexts["New book #\(currentBookCount + 1)"]
        XCTAssertEqual(lastBookTitle.label, "New book #\(currentBookCount + 1)")
    }
}
