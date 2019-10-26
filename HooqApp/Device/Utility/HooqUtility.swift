//
//  HooqUtility.swift
//  HooqApp
//
//  Created by Balaji Galave on 26/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import UIKit

struct HooqUtility {
    
    static func getAttributedInformation(from movie: Movie) -> NSAttributedString {
        
        let mutableAttributedString = NSMutableAttributedString()
        
        // Add title
        mutableAttributedString.append(NSAttributedString(string: movie.title
            , attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.black]))
        
        mutableAttributedString.append(NSAttributedString(string: "\n"))
        
        mutableAttributedString.append(NSAttributedString(string: "\(movie.releaseYear)"
        , attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black]))
        
        mutableAttributedString.append(NSAttributedString(string: "\n\n"))
        
        mutableAttributedString.append(NSAttributedString(string: "\(movie.description)"
            , attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .light), NSAttributedString.Key.foregroundColor: UIColor.black]))
        
        return mutableAttributedString
    }
    
}
