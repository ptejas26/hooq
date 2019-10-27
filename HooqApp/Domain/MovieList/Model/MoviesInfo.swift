//
//  MovieInfo.swift
//  HooqApp
//
//  Created by Balaji Galave on 25/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import Foundation

enum MovieType {
    case nowPlaying(pageNumber: Int)
    case similar(movieId: Int)
}

struct MoviesInfo {
    let movies: [Movie]
    let pageNumer: Int
    let totalPages: Int
}

struct Movie {
    let id: Int
    let title: String
    let description: String
    let releaseYear: Int
    let posterUrl: String?
    let backdropUrl: String?
}
