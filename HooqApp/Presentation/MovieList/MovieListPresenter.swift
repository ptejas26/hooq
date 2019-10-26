//
//  MovieListPresenter.swift
//  HooqApp
//
//  Created by Balaji Galave on 25/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import Foundation

protocol MovieListPresenter {
    func fetchMoviesList()
    var numberOfItems: Int { get }
    func movie(at index: Int) -> Movie?
}

class MovieListPresenterImpl: MovieListPresenter {
    
    private let fetchMovieListUseCase: FetchMovieListUseCase
    private weak var movieListView: MovieListView?
    
    private var movies = [Movie]()
    
    init(useCase: FetchMovieListUseCase, movieListView: MovieListView) {
        self.fetchMovieListUseCase = useCase
        self.movieListView = movieListView
    }
    
    func fetchMoviesList() {
        
        fetchMovieListUseCase.fetchMovieList(with: .nowPlaying(pageNumber: 1)) { [weak self] (result) in
            switch result {
            case .success(let moviesInfo):
                self?.movies = moviesInfo.movies
                self?.movieListView?.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    var numberOfItems: Int {
        return movies.count
    }
    
    func movie(at index: Int) -> Movie? {
        guard index < movies.count else { return nil }
        return movies[index]
    }
    
    
}
