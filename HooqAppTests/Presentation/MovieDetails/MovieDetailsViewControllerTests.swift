//
//  MovieDetailsViewControllerTests.swift
//  HooqAppTests
//
//  Created by Balaji Galave on 27/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import XCTest
@testable import HooqApp

class MovieDetailsViewControllerTests: XCTestCase {
    
    var controller: MovieDetailsViewController!
    var window: UIWindow!
    var mockMovieDetailsPresenter: MockMovieDetailsPresenter!
    var mockMovieDetailsRouter: MockMovieDetailsRouter!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        window = UIWindow()
        controller =  ViewUtility.getMovieDetailsViewController()
        mockMovieDetailsPresenter = MockMovieDetailsPresenter()
        mockMovieDetailsRouter = MockMovieDetailsRouter(movieDetails: mockMovieModel)
        controller.configurator =  MovieDetailsConfiguratorImpl(presenter: mockMovieDetailsPresenter, router: mockMovieDetailsRouter)
        
    }
    
    override func tearDown() {
        window = nil
        controller = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func loadView() {
        window.addSubview(controller.view)
        RunLoop.current.run(until: Date())
    }
    
    func test_Setup() {
        // when
        loadView()
        
        //Then
        XCTAssertNotNil(controller, "Controller should not be nil")
        XCTAssertNotNil(controller.configurator, "configurator should not be nil")
    }
    
    func test_SetupUI() {
        // when
        loadView()
        
        //Then
        XCTAssertEqual(controller.navigationItem.title, MovieDetailsViewController.Constant.screenTitle, "Both strings should be equal")
    }
    
    func test_collectionView_didSelectItemAt() {
        // when
        loadView()
        controller.inject(presenter: mockMovieDetailsPresenter, router: mockMovieDetailsRouter)
        
        //Then
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: window.frame, collectionViewLayout: layout)
        controller.collectionView(collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        XCTAssertTrue(mockMovieDetailsRouter.pushMovieDetailsScreen, "pushMovieDetailsScreen should be true")
        XCTAssertTrue((mockMovieDetailsPresenter.movie(at: .similarMovies, item: 0) != nil), "fetchMoviesListIsCalled should be true")
    }
    
    func test_collectionView_numberOfItemsInSection() {
        // when
        loadView()
        controller.inject(presenter: mockMovieDetailsPresenter, router: mockMovieDetailsRouter)

        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: window.frame, collectionViewLayout: layout)
        controller.collectionView(collectionView, numberOfItemsInSection: 0)
        
        // Then
        XCTAssertTrue(mockMovieDetailsPresenter.itemsAtTypeIsCalled, "numberOfItemsIsCalled should be true")
    }
    
    func test_collectionView_numberOfSections() {
        // when
        loadView()
        controller.inject(presenter: mockMovieDetailsPresenter, router: mockMovieDetailsRouter)

        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: window.frame, collectionViewLayout: layout)
        controller.numberOfSections(in: collectionView)
        
        // Then
        XCTAssertTrue(mockMovieDetailsPresenter.numberOfSectionsIsCalled, "numberOfItemsIsCalled should be true")
    }
    
}

class MockMovieDetailsPresenter: MovieDetailsPresenter {
    
    var fetchSimilarMovieListIsCalled = false
    func fetchSimilarMovieList() {
        fetchSimilarMovieListIsCalled = true
    }
    
    var numberOfSectionsIsCalled = false
    var numberOfSections: Int {
        numberOfSectionsIsCalled = true
        return 2
    }
    
    var itemsAtTypeIsCalled = false
    func items(at type: SectionType) -> Int {
        itemsAtTypeIsCalled = true
        return 1
    }
    
    var moviewAtTypeIsCalled = false
    func movie(at type: SectionType, item: Int) -> Movie? {
        moviewAtTypeIsCalled = true
        return mockMovieModel
    }
    
}

class MockMovieDetailsRouter: MovieDetailsRouter {
    
    var movieDetails: Movie
    
    init(movieDetails: Movie) {
        self.movieDetails = movieDetails
    }
    
    var pushMovieDetailsScreen = false
    func pushMovieDetailsScreen(with movie: Movie) {
        pushMovieDetailsScreen = true
    }
}

