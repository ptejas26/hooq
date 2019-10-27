//
//  ImageDownloadManagerTests.swift
//  HooqAppTests
//
//  Created by Balaji Galave on 27/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import XCTest
@testable import HooqApp

class ImageDownloadManagerTests: XCTestCase {
    
    var imageDownloadManager: ImageDownloadManager!
    var mockImageDownloadManagerImpl: MockImageDownloadManager!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        imageDownloadManager = ImageDownloadManager.shared
        mockImageDownloadManagerImpl = MockImageDownloadManager()
        ImageDownloadManager.shared.set(imageDownloadManagerProtocol: mockImageDownloadManagerImpl)
    }
    
    func test_downloadWithUrls(){
        imageDownloadManager.download(with: "", for: UIImageView())
        XCTAssertTrue(mockImageDownloadManagerImpl.downloadwithUrlStringIsCalled, "downloadwithUrlStringIsCalled should be true")
    }
    
    func test_prefetchImages(){
        imageDownloadManager.prefetchImages(with: [])
        XCTAssertTrue(mockImageDownloadManagerImpl.prefetchImagesIsCalled, "prefetchImagesIsCalled should be true")
    }
    
}
