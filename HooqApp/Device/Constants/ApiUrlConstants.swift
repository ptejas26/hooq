//
//  ApiUrlConstants.swift
//  HooqApp
//
//  Created by Balaji Galave on 25/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import Foundation

struct ApiUrlConstants {
    
    private struct Constants {
        static let apiKeyValue = "f8e3c2c5787aa2c408832caf9bdf2f26"
        static let apiKeyName = "api_key"
        static let pageKeyName = "page"
    }
    
    private struct HostUrl {
        private static let movieBaseUrl = "https://api.themoviedb.org/"
        private static let version = "3/"
        static let moviePath = movieBaseUrl + version + "movie/"
        static let imageBaseUrl = "http://image.tmdb.org/t/p/w500"
    }
    
    struct MovieInfo {
        
        private static let movieNowPlaying = "now_playing"
        private static let movieSimilar = "similar"
        
        static func apiUrlInformation(for type: MovieType) -> (url: String, parameters: [String: Any]) {
            var parameters = [String: Any]()
            var url = HostUrl.moviePath
            
            parameters[Constants.apiKeyName] = Constants.apiKeyValue
            
            switch type {
                
            case .nowPlaying(pageNumber: let page):
                parameters[Constants.pageKeyName] = page
                url.append(movieNowPlaying)
                
            case .similar(movieId: let id):
                url.append("\(id)/")
                url.append(movieSimilar)
            }
            
            return (url, parameters)
        }
    }
    
    // http://image.tmdb.org/t/p/w500/tBuabjEqxzoUBHfbyNbd8ulgy5j.jpg
    struct ImageUrl {
        
        static func imageUrl(from posterPath: String?) -> String? {
            guard let stringUrl = posterPath else { return nil }
            return HostUrl.imageBaseUrl + stringUrl
        }
    }
    
}
