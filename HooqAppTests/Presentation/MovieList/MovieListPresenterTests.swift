//
//  MovieListPresenterTests.swift
//  HooqAppTests
//
//  Created by Balaji Galave on 26/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import XCTest
@testable import HooqApp

class MovieListPresenterTests: XCTestCase {
    
    var movieListPresenter: MovieListPresenter!
    var mockFetchMovieListUseCase: MockFetchMovieListUseCase!
    var mockMovieListView: MockMovieListView!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockFetchMovieListUseCase = MockFetchMovieListUseCase()
        mockMovieListView = MockMovieListView()
        movieListPresenter = MovieListPresenterImpl(useCase: mockFetchMovieListUseCase, movieListView: mockMovieListView)
    }
    
    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_movieListView_reloadData_success() {
        movieListPresenter.fetchMoviesList()
        XCTAssertTrue(mockMovieListView.reloadDataIsCalled, "MovieListView reloadData should be called")
    }
    
    func test_movieListView_reloadData_failure() {
        mockFetchMovieListUseCase.isSuccess = false
        movieListPresenter.fetchMoviesList()
        XCTAssertFalse(mockMovieListView.reloadDataIsCalled, "MovieListView reloadData should not be called")
        XCTAssertNil(movieListPresenter.movie(at: 0))
    }
    
    func test_presenter_movieAtIndex() {
        
        let service = MockFetchMovieListService()
        let repository = FetchMovieListRepositoryImpl(service: service)
        let fetchMovieListUseCase = FetchMovieListUseCaseImpl(repository: repository)
        movieListPresenter = MovieListPresenterImpl(useCase: fetchMovieListUseCase, movieListView: mockMovieListView)
        movieListPresenter.fetchMoviesList()
        
        XCTAssertNotNil(movieListPresenter.movie(at: 0), "movie at 0 index should not be nil")
        XCTAssertTrue(movieListPresenter.numberOfItems > 0, "number of movie items must be greater than 0")
    }
}

class MockMovieListView: MovieListView {
    
    var reloadDataIsCalled = false
    func reloadData() {
        reloadDataIsCalled = true
    }
}


class MockFetchMovieListUseCase: FetchMovieListUseCase {
    
    var isSuccess = true
    
    func fetchMovieList(with type: MovieType, completion: @escaping CompletionMoviesInfo) {
        if isSuccess {
            completion(.success(mockMoviesInfo))
        }else {
            completion(.failure(customError))
        }
    }
    
}
let mockMoviesInfo = MoviesInfo(movies: [mockMovieModel], pageNumer: 1, totalPages: 10)
let mockMovieModel = Movie(id: 0, title: "This is test", description: "this is test", releaseYear: 2019, posterUrl: "http://image.tmdb.org/t/p/w500/tBuabjEqxzoUBHfbyNbd8ulgy5j.jpg", backdropUrl: "http://image.tmdb.org/t/p/w500/tBuabjEqxzoUBHfbyNbd8ulgy5j.jpg")
