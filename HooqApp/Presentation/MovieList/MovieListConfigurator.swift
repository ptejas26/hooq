//
//  MovieListConfigurator.swift
//  HooqApp
//
//  Created by Balaji Galave on 25/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import Foundation

protocol MovieListConfigurator {
    func configure(viewController: MovieListViewController)
}

class MovieListConfiguratorImpl: MovieListConfigurator {
    
    private let presenter: MovieListPresenter
    private let router: MovieListRouter
    
    init(presenter: MovieListPresenter, router: MovieListRouter) {
        self.presenter = presenter
        self.router = router
    }
    
    func configure(viewController: MovieListViewController) {
        viewController.inject(presenter: presenter, router: router)
    }
    
}

extension MovieListConfigurator {
    
    static func movieListConfigurator(with movieListView: MovieListView) -> MovieListConfiguratorImpl {
        let service = FetchMovieListServiceImpl()
        let repository = FetchMovieListRepositoryImpl(service: service)
        let usecase = FetchMovieListUseCaseImpl(repository: repository)
        let presenter = MovieListPresenterImpl(useCase: usecase, movieListView: movieListView)
        let router = MovieListRouterImpl()
        
        return MovieListConfiguratorImpl(presenter: presenter, router: router)
    }
}
