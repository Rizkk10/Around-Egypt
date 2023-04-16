//
//  Around_EgyptTests.swift
//  Around EgyptTests
//
//  Created by Rezk on 14/04/2023.
//

import XCTest
@testable import Around_Egypt

final class Around_EgyptTests: XCTestCase {

    var viewModel: ExperienceViewModel!
    
    override func setUpWithError() throws {
        viewModel = ExperienceViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testExample() throws {
        let experienceID = "1"
               let expectation = self.expectation(description: "Experience fetched")
               
               // When
               viewModel.fetch(id: experienceID)

               // Then
               DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                   XCTAssertNil(self.viewModel.experience)
                   expectation.fulfill()
               }
               waitForExpectations(timeout: 5, handler: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    

}
