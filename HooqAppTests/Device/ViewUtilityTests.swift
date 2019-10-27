//
//  ViewUtilityTests.swift
//  HooqAppTests
//
//  Created by Balaji Galave on 27/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import XCTest
@testable import HooqApp

class ViewUtilityTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func test_getMovieListViewController() {
        
        let controller = ViewUtility.getMovieListViewController()
        XCTAssertNotNil(controller, "controller should not be nil")
    }
    
    func test_getMovieDetailsViewController() {
        
        let controller = ViewUtility.getMovieDetailsViewController()
        XCTAssertNotNil(controller, "controller should not be nil")
    }
    
}
