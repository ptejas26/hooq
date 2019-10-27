//
//  MovieListRouter.swift
//  HooqApp
//
//  Created by Balaji Galave on 25/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import Foundation

protocol MovieListRouter {
    func pushMovieDetailsScreen(with movie: Movie)
}

class MovieListRouterImpl: MovieListRouter {
    
    let viewController: MovieListViewController
    
    init(viewController: MovieListViewController) {
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
