//
//  WiproImageLoadingPocTests.swift
//  WiproImageLoadingPocTests
//
//  Created by Mushaffiq on 7/9/18.
//  Copyright © 2018 Vijay. All rights reserved.
//

import XCTest
@testable import WiproImageLoadingPoc

class WiproImageLoadingPocTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    /// Fails test case if url was empty
    func testDownloadData() {
        let downloadExpectation =  expectation(description: "Successfully Downloaded")
      
            NetworkManager.sharedInstance.fetchGenericData(urlString: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") { (countryName: Welcome?, sucess) in
                if sucess && countryName != nil {
                downloadExpectation.fulfill()
                } else {
                    XCTFail()
                }
            }
            
        waitForExpectations(timeout: 10) { (error) in
            
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
