//
//  AddEditView.uitest.swift
//  MDI1-105-BookManager
//
//  Created by Christian Bonilla on 07/10/25.
//

import XCTest

class AddEditViewUITests: XCTestCase {
    func testAddBookWorks() throws {
        let app = XCUIApplication()
        app.launch()
        
        let currentBookCount = app.collectionViews.firstMatch.cells.count
        
        let addBookButton = app.buttons["Add"]
        addBookButton.tap()
        
        let titleTextField = app.textFields["Title"]
        titleTextField.tap()
        titleTextField.typeText("New book")
        
        app.buttons["Save"].tap()
        XCTAssertTrue(app.collectionViews.firstMatch.cells.count > currentBookCount)
        
        let lastBookTitle = app.collectionViews.firstMatch.cells.element(boundBy: currentBookCount).staticTexts["New book"]
        XCTAssertEqual(lastBookTitle.label, "New book")
    }
}
