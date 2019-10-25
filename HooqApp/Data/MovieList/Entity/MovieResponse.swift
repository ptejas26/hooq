//
//  MovieResponse.swift
//  HooqApp
//
//  Created by Balaji Galave on 25/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import Foundation

struct MovieResponse: Codable {
	let id : Int?
	let title : String?
    let posterPath : String?
    let releaseDate : String?
	let overview : String?
}
