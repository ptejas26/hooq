//
//  MovieDetailsPresenter.swift
//  HooqApp
//
//  Created by Balaji Galave on 26/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import Foundation

enum SectionType: Int {
    case movieDetails = 0
    case similarMovies = 1
    
    var numberOfColumns: Int {
        switch self {
        case .movieDetails:
            return 1

        case .similarMovies:
            return 3
        }
    }
    
}

protocol MovieDetailsPresenter {
    func fetchSimilarMovieList()
    var numberOfSections: Int { get }
    func items(at type: SectionType) -> Int
    func movie(at type: SectionType, item: Int) -> Movie?
}

class MovieDetailsPresenterImpl: MovieDetailsPresenter {
    
    private let fetchMovieListUseCase: FetchMovieListUseCase
    private weak var movieDetailsView: MovieDetailsView?
    
    private var similarMovies = [Movie]()
    private let movieDetails: Movie
    
    init(useCase: FetchMovieListUseCase, movieDetailsView: MovieDetailsView, movieDetails: Movie) {
        self.fetchMovieListUseCase = useCase
        self.movieDetailsView = movieDetailsView
        self.movieDetails = movieDetails
    }
    
    func fetchSimilarMovieList() {
        fetchMovieListUseCase.fetchMovieList(with: .similar(movieId: movieDetails.id)) { [weak self] (result) in
            switch result {
            case .success(let moviesInfo):
                self?.similarMovies = moviesInfo.movies
                self?.movieDetailsView?.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    var numberOfSections: Int {
        return 2
    }
    
    func items(at type: SectionType) -> Int {
        switch type {
        case SectionType.movieDetails:
            return 2
            
        case SectionType.similarMovies:
            return similarMovies.count
        }
    }
    
    func movie(at type: SectionType, item: Int) -> Movie? {
        
        switch type {
        case SectionType.movieDetails:
            return movieDetails
            
        case SectionType.similarMovies:
            if item < similarMovies.count {
                return similarMovies[item]
            }
        }
        return nil
    }
    
}

