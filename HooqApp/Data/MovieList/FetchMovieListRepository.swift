//
//  FetchMovieListRepository.swift
//  HooqApp
//
//  Created by Balaji Galave on 25/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import Foundation

protocol FetchMovieListRepository {
    func fetchMovieList(with type: MovieType, completion: @escaping CompletionMoviesInfoResponse)
}

class FetchMovieListRepositoryImpl: FetchMovieListRepository {
    
    private let service: FetchMovieListService
    
    init(service: FetchMovieListService) {
        self.service = service
    }
    
    func fetchMovieList(with type: MovieType, completion: @escaping CompletionMoviesInfoResponse) {
        service.fetchMovieList(with: type, completion: completion)
    }
    
}
