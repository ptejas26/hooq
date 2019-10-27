//
//  MovieListViewControllerTests.swift
//  HooqAppTests
//
//  Created by Balaji Galave on 27/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import XCTest
@testable import HooqApp

class MovieListViewControllerTests: XCTestCase {
    
    var controller: MovieListViewController!
    var window: UIWindow!
    var mockMovieListPresenter: MockMovieListPresenter!
    var mockMovieListRouter: MockMovieListRouter!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        window = UIWindow()
        controller =  ViewUtility.getMovieListViewController()
        mockMovieListPresenter = MockMovieListPresenter()
        mockMovieListRouter = MockMovieListRouter()
        controller.configurator =  MovieListConfiguratorImpl(presenter: mockMovieListPresenter, router: mockMovieListRouter)
        
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
        XCTAssertEqual(controller.navigationItem.title, MovieListViewController.Constant.screenTitle, "Both strings should be equal")
    }
    
    func test_collectionView_didSelectItemAt() {
        // when
        loadView()
        controller.inject(presenter: mockMovieListPresenter, router: mockMovieListRouter)
        
        //Then
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: window.frame, collectionViewLayout: layout)
        controller.collectionView(collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        XCTAssertTrue(mockMovieListRouter.pushMovieDetailsScreenIsCalled, "pushMovieDetailsScreenIsCalled should be true")
        XCTAssertTrue(mockMovieListPresenter.movieAtIndexIsCalled, "fetchMoviesListIsCalled should be true")
    }
    
    func test_collectionView_prefetchItemsAt() {
        // when
        loadView()
        controller.inject(presenter: mockMovieListPresenter, router: mockMovieListRouter)
        let mockImageDownloadManagerImpl = MockImageDownloadManager()
        ImageDownloadManager.shared.set(imageDownloadManagerProtocol: mockImageDownloadManagerImpl)
        
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: window.frame, collectionViewLayout: layout)
        controller.collectionView(collectionView, prefetchItemsAt: [IndexPath(item: 0, section: 0)])
        
        // Then
        XCTAssertTrue(mockImageDownloadManagerImpl.prefetchImagesIsCalled, "prefetchImagesIsCalled should be true")
    }
    
    func test_collectionView_numberOfItemsInSection() {
        // when
        loadView()
        controller.inject(presenter: mockMovieListPresenter, router: mockMovieListRouter)
        
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: window.frame, collectionViewLayout: layout)
        controller.collectionView(collectionView, numberOfItemsInSection: 0)
        
        // Then
        XCTAssertTrue(mockMovieListPresenter.numberOfItemsIsCalled, "numberOfItemsIsCalled should be true")
    }
    
}

class MockMovieListPresenter: MovieListPresenter {
    
    var fetchMoviesListIsCalled = false
    func fetchMoviesList() {
        fetchMoviesListIsCalled = true
    }
    
    var numberOfItemsIsCalled = false
    var numberOfItems: Int {
        numberOfItemsIsCalled = true
        return 1
    }
    
    var movieAtIndexIsCalled = false
    func movie(at index: Int) -> Movie? {
        movieAtIndexIsCalled = true
        return mockMovieModel
    }
    
}

class MockMovieListRouter: MovieListRouter {
    
    var  pushMovieDetailsScreenIsCalled = false
    func pushMovieDetailsScreen(with movie: Movie) {
        pushMovieDetailsScreenIsCalled = true
    }
}
