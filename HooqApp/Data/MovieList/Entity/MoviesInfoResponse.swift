//
//  MoviesInfoReponse.swift
//  HooqApp
//
//  Created by Balaji Galave on 25/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import Foundation

struct MoviesInfoResponse: Codable {
	let results : [MovieResponse]?
	let page : Int?
	let totalPages : Int?
}
