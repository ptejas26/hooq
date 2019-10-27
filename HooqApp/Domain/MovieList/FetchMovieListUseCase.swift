//
//  FetchMovieListUseCase.swift
//  HooqApp
//
//  Created by Balaji Galave on 25/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import Foundation

typealias CompletionMoviesInfo = (Result<MoviesInfo, Error>) -> Void

protocol FetchMovieListUseCase {
    func fetchMovieList(with type: MovieType, completion: @escaping CompletionMoviesInfo)
}

class FetchMovieListUseCaseImpl: FetchMovieListUseCase {
    
    private let repository: FetchMovieListRepository
    
    init(repository: FetchMovieListRepository) {
        self.repository = repository
    }
    
    func fetchMovieList(with type: MovieType, completion: @escaping CompletionMoviesInfo) {
        
        repository.fetchMovieList(with: type) { (result) in
            switch result {
            case .success(let moviesInfoResponse):
                let moviesInfo = MovieListApiToUIMapper.getMovieList(from: moviesInfoResponse)
                completion(.success(moviesInfo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
