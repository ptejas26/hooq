//
//  MoviePosterCollectionViewCell.swift
//  HooqApp
//
//  Created by Balaji Galave on 25/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import UIKit

class MoviePosterCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var viewBackground: UIView! {
        didSet {
            viewBackground.round(with: 4, withBorder: false, borderColor: UIColor.clear)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dropShadow()
    }
    
    func configureCell(with movie: Movie) {
        guard let url = movie.posterUrl else {
            return
        }
        ImageDownloadManager.shared.download(with: url, for: imageView)
    }

}
