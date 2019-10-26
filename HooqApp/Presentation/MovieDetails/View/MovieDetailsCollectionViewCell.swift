//
//  MovieDetailsCollectionViewCell.swift
//  HooqApp
//
//  Created by Balaji Galave on 26/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import UIKit

class MovieDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var posterImageView: UIImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(with movie: Movie) {
        if let urlString = movie.backdropUrl {
            ImageDownloadManager.shared.download(with: urlString, for: posterImageView)
        }
    }
        
}
