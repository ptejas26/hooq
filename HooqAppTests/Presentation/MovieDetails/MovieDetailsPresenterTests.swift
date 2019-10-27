//
//  MovieDetailsPresenterTests.swift
//  HooqAppTests
//
//  Created by Balaji Galave on 26/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import XCTest
@testable import HooqApp

class MovieDetailsPresenterTests: XCTestCase {
    
    var movieDetailsPresenter: MovieDetailsPresenter!
    var mockFetchMovieListUseCase: MockFetchMovieListUseCase!
    var mockMovieDetailsView: MockMovieDetailsView!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockFetchMovieListUseCase = MockFetchMovieListUseCase()
        mockMovieDetailsView = MockMovieDetailsView()
        movieDetailsPresenter = MovieDetailsPresenterImpl(useCase: mockFetchMovieListUseCase, movieDetailsView: mockMovieDetailsView, movieDetails: mockMovieModel)
    }
    
    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_movieDetails_reloadData_success() {
        movieDetailsPresenter.fetchSimilarMovieList()
        XCTAssertTrue(mockMovieDetailsView.reloadDataIsCalled, "MovieDetailsView reloadData should be called")
    }
    
    func test_movieDetails_reloadData_failure() {
        mockFetchMovieListUseCase.isSuccess = false
        movieDetailsPresenter.fetchSimilarMovieList()
        XCTAssertFalse(mockMovieDetailsView.reloadDataIsCalled, "MovieDetailsView reloadData should not be called")
        XCTAssertNil(movieDetailsPresenter.movie(at: .similarMovies, item: 0), "movie should be nil")
    }
    
    func test_presenter_movieAtIndex() {
        
        let service = MockFetchMovieListService()
        let repository = FetchMovieListRepositoryImpl(service: service)
        let fetchMovieListUseCase = FetchMovieListUseCaseImpl(repository: repository)
        movieDetailsPresenter = MovieDetailsPresenterImpl(useCase: fetchMovieListUseCase, movieDetailsView: mockMovieDetailsView, movieDetails: mockMovieModel)
        movieDetailsPresenter.fetchSimilarMovieList()
        
        XCTAssertNotNil(movieDetailsPresenter.movie(at: .movieDetails, item: 0), "movie at 0 index should not be nil")
        XCTAssertTrue(movieDetailsPresenter.items(at: .similarMovies) > 0, "number of movie items must be greater than 0")
        XCTAssertEqual(movieDetailsPresenter.items(at: .movieDetails), 2, "items value should be equal")
        XCTAssertEqual(movieDetailsPresenter.numberOfSections, 2, "items value should be equal")
    }
    
    func test_presenter_sectionType() {
        let movieDetailsSectionType = SectionType(rawValue: 0)
        XCTAssertEqual(movieDetailsSectionType?.numberOfColumns, 1, "numberOfColumns should be 1")
        
        let moviesimilarSectionType = SectionType(rawValue: 1)
        XCTAssertEqual(moviesimilarSectionType?.numberOfColumns, 3, "numberOfColumns should be 1")
    }
    
}

class MockMovieDetailsView: MovieDetailsView {
    
    var reloadDataIsCalled = false
    func reloadData() {
        reloadDataIsCalled = true
    }
}
