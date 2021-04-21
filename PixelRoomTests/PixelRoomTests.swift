//
//  PixelRoomTests.swift
//  PixelRoomTests
//
//  Created by Igor Lipovac on 01/03/2021.
//

import XCTest
@testable import PixelRoom

class PixelRoomTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    // MARK: - Some simple tests
    func testGalleryDataSource() throws {
        let datasource = GalleryDataSource()
        
        let expectation = XCTestExpectation(description: "Should load all images")
        datasource.reloadPhotos {
            XCTAssertEqual(datasource.numberOfSections, 3)
            XCTAssertEqual(datasource.numberOfItemsInSection(0), 5)
            XCTAssertEqual(datasource.numberOfItemsInSection(1), 6)
            
            // Let's check that all items have a name,
            // url, and generated thumbnail
            for section in 0..<datasource.numberOfSections {
                for index in 0..<datasource.numberOfItemsInSection(section) {
                    let item = datasource.item(at: index, inSection: section)
                    XCTAssertNotNil(item)
                    XCTAssertNotNil(item.name)
                    XCTAssertNotNil(item.thumbnail)
                    XCTAssertNotNil(item.url)
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30.0)
    }
}
