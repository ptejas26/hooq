//
//  MovieDetailsCollectionViewCell.swift
//  HooqApp
//
//  Created by Balaji Galave on 26/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import UIKit

class MovieDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    func configureCell(with movie: Movie) {
        if let urlString = movie.backdropUrl {
            ImageDownloadManager.shared.download(with: urlString, for: posterImageView)
        }
    }
        
}
