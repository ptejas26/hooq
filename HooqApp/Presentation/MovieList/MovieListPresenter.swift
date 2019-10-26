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
    private var currentPage: Int = 0
    private var totalNumberOfPages: Int = 1
    
    init(useCase: FetchMovieListUseCase, movieListView: MovieListView) {
        self.fetchMovieListUseCase = useCase
        self.movieListView = movieListView
        currentPage = 0
    }
    
    func fetchMoviesList() {
        
        currentPage += 1
        guard currentPage <= totalNumberOfPages else {
            return
        }
        
        fetchMovieListUseCase.fetchMovieList(with: .nowPlaying(pageNumber: currentPage)) { [weak self] (result) in
            switch result {
            case .success(let moviesInfo):
                self?.movies.append(contentsOf: moviesInfo.movies)
                self?.totalNumberOfPages = moviesInfo.totalPages
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
