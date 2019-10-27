//
//  MovieListRouterTests.swift
//  HooqAppTests
//
//  Created by Balaji Galave on 27/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import XCTest
@testable import HooqApp

class MovieListRouterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func test_pushMovieDetailsScreen() {
        let movieListViewController = MovieListViewController()

        let navigationController = UINavigationController(rootViewController: movieListViewController)
        
        let movieListRouter = MovieListRouterImpl(viewController: movieListViewController)
        
        movieListRouter.pushMovieDetailsScreen(with: mockMovieModel)
        
        let exp = expectation(description: "navigation did not push view controller")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            XCTAssertEqual(navigationController.viewControllers.count, 2, "navigationController should have 2 viewControllers in navigation stack")
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2)
       
    }
    
}
