//
//  BookListUITests.swift
//  MDI1-105-BookManagerUITests
//
//  Created by Christian Bonilla on 02/10/25.
//

import XCTest

final class BookListUITests: XCTestCase {
    
    func testBookListViewUIElements() {
        let app = XCUIApplication()
        app.launch()
        
        // Verify title
        XCTAssertTrue(app.navigationBars["My Books"].exists)
        
        // Verify add button
        XCTAssertTrue(app.buttons["Add"].exists)
        
        // Verify filter button
        XCTAssertTrue(app.buttons["line.horizontal.3.decrease.circle"].exists)
    }
    
    func testBookListItemDisplaysCorrectly() {
        let app = XCUIApplication()
        app.launch()
        
        let firstBookTitle = app.staticTexts["The Two Towers"]
        XCTAssertTrue(firstBookTitle.exists)
        
        let favoriteIcon = app.images["heart.fill"]
        XCTAssertTrue(favoriteIcon.exists)
    }
}
