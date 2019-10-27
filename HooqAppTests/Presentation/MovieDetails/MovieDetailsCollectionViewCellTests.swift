//
//  MovieDetailsCollectionViewCellTests.swift
//  HooqAppTests
//
//  Created by Balaji Galave on 27/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import XCTest
@testable import HooqApp

class MovieDetailsCollectionViewCellTests: XCTestCase {
    
    var cell: MovieDetailsCollectionViewCell!
    var mockImageDownloadManagerImpl: MockImageDownloadManager!
    var imageView = UIImageView()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cell = MovieDetailsCollectionViewCell()
        cell.posterImageView = imageView
        mockImageDownloadManagerImpl = MockImageDownloadManager()
        ImageDownloadManager.shared.set(imageDownloadManagerProtocol: mockImageDownloadManagerImpl)
    }
    
    func test_configureCell() {
        cell.configureCell(with: mockMovieModel)
        XCTAssertTrue(mockImageDownloadManagerImpl.downloadwithUrlStringIsCalled, "downloadwithUrlStringIsCalled should be true")
    }
    
}
