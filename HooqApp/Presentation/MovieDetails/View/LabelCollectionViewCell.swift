//
//  LabelCollectionViewCell.swift
//  HooqApp
//
//  Created by Balaji Galave on 26/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    func configureCell(with movie: Movie) {
        label.attributedText = HooqUtility.getAttributedInformation(from: movie)
    }

}


extension LabelCollectionViewCell {
    /// Used only for Unit Test
    var attributedText: NSAttributedString? {
        return label.attributedText
    }
}
