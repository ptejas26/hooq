//
//  MovieListApiToUIMapper.swift
//  HooqApp
//
//  Created by Balaji Galave on 25/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import Foundation

struct MovieListApiToUIMapper {
    
    static func getMovieList(from moviesInfoResponse: MoviesInfoResponse) -> MoviesInfo {
        
        guard let moviesListResponse = moviesInfoResponse.results, !moviesListResponse.isEmpty else { return MoviesInfo(movies: [], pageNumer: 0) }
        
        let moviesList = moviesListResponse.map{ getMovie(from: $0) }
        let moviesInfo = MoviesInfo(movies: moviesList, pageNumer: moviesInfoResponse.page ?? 0)
        
        return moviesInfo
    }
    
    private static func getMovie(from movieResponse: MovieResponse) -> Movie {
        let year = DateUtility.year(from: movieResponse.releaseDate)
        
        let postUrl = ApiUrlConstants.ImageUrl.imageUrl(from: movieResponse.posterPath ?? "")
        
        let movie = Movie(title: movieResponse.title ?? "", description: movieResponse.overview ?? "", releaseYear: year, posterUrl: postUrl)
        
        return movie
    }
}
