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
    
    func testPhotoEditorModel() throws {
        // ran out of time, but in order to test the PhotoEditorModel
        // I would first create a PhotoItem with a know image,
        // mock the PhotoEditorView,
        // call editorDidChangePixellateInputScaleValue with a known
        // parameter
        // compare the resulting edited image with a previously
        // edited version to check for differences (note: this would
        // work only for deterministic filters; e.g., it wouldn't work
        // with CIRandomGenerator combined with any compositional
        // filter)
        // storePixellateEdits and loadPixellateEdits could be tested if
        // decoupled from UserDefaults.standard (i.e., passing
        // UserDefaults.standard to the PhotoEditorModel initializer as a
        // parameter, so as to be able to, during the tests, create
        // an instance of UserDefaults and use it for the tests) [this
        // particular test could've catched the different (string) keys
        // that were present in the code (see commit 2be0863)]
    }
}
