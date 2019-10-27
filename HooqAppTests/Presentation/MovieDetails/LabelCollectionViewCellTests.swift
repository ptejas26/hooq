//
//  LabelCollectionViewCellTests.swift
//  HooqAppTests
//
//  Created by Balaji Galave on 27/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import XCTest
@testable import HooqApp

class LabelCollectionViewCellTests: XCTestCase {
    
    var cell: LabelCollectionViewCell!
    var label = UILabel()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cell = LabelCollectionViewCell()
        cell.label = label
    }
    
    func test_configureCell() {
        cell.configureCell(with: mockMovieModel)
        XCTAssertEqual(cell.attributedText, HooqUtility.getAttributedInformation(from: mockMovieModel), "both attributedText should be same")
    }
    
}
