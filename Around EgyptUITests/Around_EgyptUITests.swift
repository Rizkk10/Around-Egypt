//
//  Around_EgyptUITests.swift
//  Around EgyptUITests
//
//  Created by Rezk on 14/04/2023.
//

import XCTest

final class Around_EgyptUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let experienceListTable = app.tables["ExperienceListTable"]
        XCTAssertFalse(experienceListTable.exists)
        let firstCell = experienceListTable.cells.firstMatch
        XCTAssertFalse(firstCell.waitForExistence(timeout: 5.0))
        
        
        // Check ExperienceScreen content
        let titleLabel = app.staticTexts["ExperienceTitle"]
        XCTAssertFalse(titleLabel.exists)
        let cityLabel = app.staticTexts["ExperienceCity"]
        XCTAssertFalse(cityLabel.exists)
        let likesLabel = app.staticTexts["ExperienceLikes"]
        XCTAssertFalse(likesLabel.exists)
        let viewsLabel = app.staticTexts["ExperienceViews"]
        XCTAssertFalse(viewsLabel.exists)
        let descriptionLabel = app.staticTexts["ExperienceDescription"]
        XCTAssertFalse(descriptionLabel.exists)
        let coverPhotoImage = app.images["ExperienceCoverPhoto"]
        XCTAssertFalse(coverPhotoImage.exists)
        
        // Swipe down to check scroll view
        let scrollView = app.scrollViews["ExperienceScrollView"]
        XCTAssertFalse(scrollView.exists)
        
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
