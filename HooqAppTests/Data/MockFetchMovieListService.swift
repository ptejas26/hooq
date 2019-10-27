//
//  MockFetchMovieListService.swift
//  HooqAppTests
//
//  Created by Balaji Galave on 26/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//
import Foundation
@testable import HooqApp

class MockFetchMovieListService: FetchMovieListService {
    
    var isSuccess = true
    
    func fetchMovieList(with type: MovieType, completion: @escaping CompletionMoviesInfoResponse) {
        
        if isSuccess {
            let stubGenerator = StubGenerator()
            if let data = stubGenerator.getMovieData() {
                do {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    let responseModel = try jsonDecoder.decode(MoviesInfoResponse.self, from: data)
                    
                    completion(.success(responseModel))
                    
                } catch let error {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }else {
            completion(.failure(customError))
        }
    }
    
}
