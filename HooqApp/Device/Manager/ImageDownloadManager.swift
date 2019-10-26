//
//  ImageDownloadManager.swift
//  HooqApp
//
//  Created by Balaji Galave on 26/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import Foundation
import SDWebImage

protocol ImageDownloadManagerProtocol {
    func download(with urlString: String, for imageView: UIImageView)
    func prefetchImages(with stringUrls: [String])
}

struct ImageDownloadManager {
    
    private var imageDownloadManagerProtocol: ImageDownloadManagerProtocol?
    private static var imageDownloadManager: ImageDownloadManager?
    
    private init() {
        
    }
    
    static var shared: ImageDownloadManager {
        if imageDownloadManager == nil {
            imageDownloadManager = ImageDownloadManager()
            imageDownloadManager?.set(imageDownloadManagerProtocol: ImageDownloadManagerImpl())
        }
        return imageDownloadManager!
    }
    
    mutating func set(imageDownloadManagerProtocol: ImageDownloadManagerProtocol) {
        self.imageDownloadManagerProtocol = imageDownloadManagerProtocol
    }
    
    func download(with urlString: String, for imageView: UIImageView) {
        imageDownloadManagerProtocol?.download(with: urlString, for: imageView)
    }
    
    func prefetchImages(with stringUrls: [String]) {
        imageDownloadManagerProtocol?.prefetchImages(with: stringUrls)
    }
    
}

fileprivate struct ImageDownloadManagerImpl: ImageDownloadManagerProtocol {
    
    func download(with urlString: String, for imageView: UIImageView) {
        imageView.sd_setImage(with: URL(string: urlString), placeholderImage: nil)
    }
    
    func prefetchImages(with stringUrls: [String]) {
        let urls = stringUrls.compactMap{ URL(string: $0) }
        SDWebImagePrefetcher.shared().prefetchURLs(urls)
    }
}
