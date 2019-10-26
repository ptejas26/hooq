//
//  ViewUtility.swift
//  HooqApp
//
//  Created by Balaji Galave on 26/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import UIKit

struct ViewUtility {
    
    // MARK: StoryBaord Utility Methods
    private static func getMainStoryBaord() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    // MARK: ViewController Utility Methods
    
    static func getMovieListViewController() -> MovieListViewController? {
        let storyBoard = getMainStoryBaord()
        let id = "MovieListViewControllerId"
        return storyBoard.instantiateViewController(withIdentifier: id) as? MovieListViewController
    }
    
    static func getMovieDetailsViewController() -> MovieDetailsViewController? {
        let storyBoard = getMainStoryBaord()
        let id = "MovieDetailsViewControllerId"
        return storyBoard.instantiateViewController(withIdentifier: id) as? MovieDetailsViewController
    }
    
}
