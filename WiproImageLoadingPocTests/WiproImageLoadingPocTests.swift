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
    
    let testViewcontroller = ViewController()
    override func setUp() {
        super.setUp()
        testViewcontroller.loadView()
        testViewcontroller.viewDidLoad()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testHasViewInitiated() {
        XCTAssertNotNil(testViewcontroller.view)
    }
    
    func testHasATableView() {
        XCTAssertNotNil(testViewcontroller.countryContactsTableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(testViewcontroller.countryContactsTableView.delegate)
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(testViewcontroller.countryContactsTableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(testViewcontroller.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(testViewcontroller.responds(to: #selector(testViewcontroller.numberOfSections(in:))))
        XCTAssertTrue(testViewcontroller.responds(to: #selector(testViewcontroller.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(testViewcontroller.responds(to: #selector(testViewcontroller.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewCellHasReuseIdentifier() {
        let cell = testViewcontroller.tableView(testViewcontroller.countryContactsTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? TableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "contactCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    /// Fails test case if url was empty
    func testCanDownloadData() {
        
        let downloadExpectation =  expectation(description: "Successfully Downloaded")
            NetworkManager.sharedInstance.fetchGenericData(urlString: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") { (countryName: Welcome?, sucess) in
                if sucess && countryName != nil {
                downloadExpectation.fulfill()
                } else {
                    XCTFail()
                }
            }
        waitForExpectations(timeout: 10) { (error) in
            if error != nil {
                XCTFail()
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
