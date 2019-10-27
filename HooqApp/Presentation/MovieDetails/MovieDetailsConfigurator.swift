//
//  MovieDetailsConfigurator.swift
//  HooqApp
//
//  Created by Balaji Galave on 26/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import Foundation

protocol MovieDetailsConfigurator {
    func configure(viewController: MovieDetailsViewController)
}

class MovieDetailsConfiguratorImpl: MovieDetailsConfigurator {
    
    private let presenter: MovieDetailsPresenter
    private let router: MovieDetailsRouter
    
    init(presenter: MovieDetailsPresenter, router: MovieDetailsRouter) {
        self.presenter = presenter
        self.router = router
    }
    
    func configure(viewController: MovieDetailsViewController) {
        viewController.inject(presenter: presenter, router: router)
    }
    
}

extension MovieDetailsConfigurator {
    
    static func movieDetailsConfigurator(with movieListView: MovieDetailsViewController, router: MovieDetailsRouter) -> MovieDetailsConfiguratorImpl {
        let service = FetchMovieListServiceImpl()
        let repository = FetchMovieListRepositoryImpl(service: service)
        let usecase = FetchMovieListUseCaseImpl(repository: repository)
        let presenter = MovieDetailsPresenterImpl(useCase: usecase, movieDetailsView: movieListView, movieDetails: router.movieDetails)
        
        return MovieDetailsConfiguratorImpl(presenter: presenter, router: router)
    }
}
