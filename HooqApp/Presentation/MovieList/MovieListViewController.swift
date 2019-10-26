//
//  MovieListViewController.swift
//  HooqApp
//
//  Created by Balaji Galave on 25/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import UIKit

protocol MovieListView: class {
    func reloadData()
}

/// This follows MVP-Clean architectural pattern
class MovieListViewController: BaseViewController {
    
    struct Constant {
        static let cellId = "MoviePosterCollectionViewCell"
        static let screenTitle = "Movie List"
    }
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.prefetchDataSource = self
            collectionView.alwaysBounceVertical = true
            collectionView.register(UINib(nibName: Constant.cellId, bundle: nil), forCellWithReuseIdentifier: Constant.cellId)
        }
    }
    
    
    var configurator: MovieListConfigurator!
    private var presenter: MovieListPresenter?
    private var router: MovieListRouter?
    
    func inject(presenter: MovieListPresenter, router: MovieListRouter) {
        self.presenter = presenter
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configurator = MovieListConfiguratorImpl.movieListConfigurator(with: self)
        configurator.configure(viewController: self)
        presenter?.fetchMoviesList()
        
        setupNavigationBar()
        
        if #available(iOS 13.0, *) {
            collectionView.setCollectionViewLayout(makeLayout(), animated: true)
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.title = Constant.screenTitle
    }
    
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.cellId, for: indexPath) as? MoviePosterCollectionViewCell,
            let movie = presenter?.movie(at: indexPath.item) else {
            return UICollectionViewCell()
        }
        cell.configureCell(with: movie)
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        return cell
    }
    
    @available(iOS 13.0, *)
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0), heightDimension: NSCollectionLayoutDimension.absolute(170)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),  heightDimension: .absolute(170))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
            return section
        }
        return layout
    }
    
    // Prefeching of next pages shall be handled in different way but for time being this is what we are doing
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let totalCount = presenter?.numberOfItems else {
            return
        }
        if indexPath.item == (totalCount - 10) {
            presenter?.fetchMoviesList()
        }
    }
    
}

extension MovieListViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        // Fetch the next images and get ready to display once user scrolls ups and down
        let stringUrls = indexPaths.compactMap { (indexPath) -> String? in
            if let movie = presenter?.movie(at: indexPath.row) {
                return movie.posterUrl
            }
            return nil
        }
        ImageDownloadManager.prefetchImages(with: stringUrls)
    }
}

extension MovieListViewController: MovieListView {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}
