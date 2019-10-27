//
//  UIColorExtensionTests.swift
//  HooqAppTests
//
//  Created by Balaji Galave on 27/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import XCTest
@testable import HooqApp

class UIColorExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_colors() {
        XCTAssertEqual(UIColor.navigationTint(), .black, "Both colors should be the same")
        XCTAssertEqual(UIColor.navigationBarBackground(), .white, "Both colors should be the same")
    }
    
}
