//
//  FetchMovieListUseCaseTests.swift
//  HooqAppTests
//
//  Created by Balaji Galave on 26/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import XCTest
@testable import HooqApp

class FetchMovieListUseCaseTests: XCTestCase {
    
    var fetchMovieListUseCase: FetchMovieListUseCase!
    var service: MockFetchMovieListService!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        configure()
    }
    
    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func configure() {
        service = MockFetchMovieListService()
        let repository = FetchMovieListRepositoryImpl(service: service)
        fetchMovieListUseCase = FetchMovieListUseCaseImpl(repository: repository)
    }
    
    func test_fetchMovieList_success() {
        let expectations = expectation(description: "result closure should trigger")
        
        fetchMovieListUseCase?.fetchMovieList(with: .nowPlaying(pageNumber: 1), completion: { (result) in
            
            switch result {
            case .success(let movieInfo):
                
                XCTAssertEqual(movieInfo.movies.count, 20, "movies count should be 20")
                XCTAssertEqual(movieInfo.pageNumer, 1, "page number should be 1")
                expectations.fulfill()
                
            case .failure(_):
                XCTFail("failure should not get call")
            }
        })
        
        wait(for: [expectations], timeout: 5)
    }
    
    func test_fetchMovieList_failure() {
        service.isSuccess = false
        let expectations = expectation(description: "result closure should trigger")
        
        fetchMovieListUseCase?.fetchMovieList(with: .nowPlaying(pageNumber: 1), completion: { (result) in
            
            switch result {
            case .success(_):
                XCTFail("failure should not get call")
                
            case .failure(_):
                expectations.fulfill()
            }
        })
        
        wait(for: [expectations], timeout: 5)
    }
    
}
