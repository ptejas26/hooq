//
//  StubGenerator.swift
//  HooqAppTests
//
//  Created by Balaji Galave on 26/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import Foundation

class StubGenerator {
    private func getFileContentsAsJson(fileUrl: URL) -> Data? {
        if let data = try? Data(contentsOf: fileUrl) {
            return data
        }
        return nil
    }
    
    func getMovieData() -> Data? {
        let testBundle = Bundle(for: type(of: self))
        
        if let fileUrl = testBundle.url(forResource: "moviesInfo", withExtension: "json") {
            if let data = getFileContentsAsJson(fileUrl: fileUrl) {
                return data
            }
        }
        return nil
    }
}
