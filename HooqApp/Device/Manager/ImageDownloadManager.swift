//
//  ImageDownloadManager.swift
//  HooqApp
//
//  Created by Balaji Galave on 26/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import Foundation
import SDWebImage

struct ImageDownloadManager {
    
    static func download(with urlString: String, for imageView: UIImageView) {
        imageView.sd_setImage(with: URL(string: urlString), placeholderImage: nil)
    }
    
    static func prefetchImages(with stringUrls: [String]) {
        let urls = stringUrls.compactMap{ URL(string: $0) }
        SDWebImagePrefetcher.shared().prefetchURLs(urls)
    }
    
}

