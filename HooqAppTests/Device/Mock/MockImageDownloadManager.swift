//
//  MockImageDownloadManager.swift
//  HooqAppTests
//
//  Created by Balaji Galave on 27/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import XCTest
@testable import HooqApp

class MockImageDownloadManager: ImageDownloadManagerProtocol {
    
    var downloadwithUrlStringIsCalled = false
    func download(with urlString: String, for imageView: UIImageView) {
        downloadwithUrlStringIsCalled = true
    }
    
    var prefetchImagesIsCalled = false
    func prefetchImages(with stringUrls: [String]) {
        prefetchImagesIsCalled = true
    }
    
}
