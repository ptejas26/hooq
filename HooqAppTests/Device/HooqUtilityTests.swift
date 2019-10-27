//
//  HooqUtilityTests.swift
//  HooqAppTests
//
//  Created by Balaji Galave on 27/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import XCTest
@testable import HooqApp

class HooqUtilityTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func test_getAttributedInformation() {
        let model = mockMovieModel
        let attributedString = HooqUtility.getAttributedInformation(from: model)
        XCTAssertTrue(attributedString.string.contains(model.title), "attributedString should contain a movie \(model.title)")
        XCTAssertTrue(attributedString.string.contains(model.description), "attributedString should contain a movie \(model.description)")
        XCTAssertTrue(attributedString.string.contains("\(model.releaseYear)"), "attributedString should contain a movie \(model.releaseYear)")
    }
    
}
