//
//  MovieDetailsRouter.swift
//  HooqApp
//
//  Created by Balaji Galave on 26/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import Foundation

protocol MovieDetailsRouter {
    var movieDetails: Movie { set get }
    func pushMovieDetailsScreen(with movie: Movie)
}

class MovieDetailsRouterImpl: MovieDetailsRouter {
    
    var movieDetails: Movie
    let viewController: MovieDetailsViewController
    
    init(movieDetails: Movie, viewController: MovieDetailsViewController) {
        self.movieDetails  = movieDetails
        self.viewController = viewController
    }
    
    func pushMovieDetailsScreen(with movie: Movie) {
        
        guard let movieDetailsViewController = ViewUtility.getMovieDetailsViewController() else {
            return
        }
        let router = MovieDetailsRouterImpl(movieDetails: movie, viewController: movieDetailsViewController)
        movieDetailsViewController.configurator = MovieDetailsConfiguratorImpl.movieDetailsConfigurator(with: movieDetailsViewController, router: router)
        viewController.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}
