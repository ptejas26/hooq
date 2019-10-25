//
//  FetchMovieListService.swift
//  HooqApp
//
//  Created by Balaji Galave on 25/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import Foundation

typealias CompletionMoviesInfoResponse = (Result<MoviesInfoResponse, Error>) -> Void

protocol FetchMovieListService {
    func fetchMovieList(with type: MovieType, completion: @escaping CompletionMoviesInfoResponse)
}

class FetchMovieListServiceImpl: BaseService, FetchMovieListService {
    
    func fetchMovieList(with type: MovieType, completion: @escaping CompletionMoviesInfoResponse) {
        
        let (urlString, parameters) = ApiUrlConstants.MovieInfo.apiUrlInformation(for: type)
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "com.hooq.categotylist", code: 45454, userInfo: nil) as Error))
            return
        }
        
        self.loadData(type: MoviesInfoResponse.self,
                      url: url,
                      method: .get,
                      parameters: parameters) { response, error, data in
                        
                        guard let response = response, error == nil else {
                            completion(.failure(error!))
                            return
                        }
                        completion(.success(response))
        }
    }
    
}
