//
//  DateUtilityTests.swift
//  HooqAppTests
//
//  Created by Balaji Galave on 27/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import XCTest
@testable import HooqApp

class DateUtilityTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    func test_year_from_date() {
        
        let date = "2019-02-03"
        let year = DateUtility.year(from: date)
        XCTAssertEqual(year, 2019, "year should be 2019")
    }
    
    func test_year_from_date_given_empty_string() {
        let date = ""
        let year = DateUtility.year(from: date)
        XCTAssertEqual(year, 0, "year should be 0")
    }
    
    func test_year_from_date_given_nil_string() {
        let year = DateUtility.year(from: nil)
        XCTAssertEqual(year, 0, "year should be 0")
    }
    
}
