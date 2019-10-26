//
//  MovieDetailsViewController.swift
//  HooqApp
//
//  Created by Balaji Galave on 26/10/19.
//  Copyright © 2019 Balaji Galave. All rights reserved.
//

import UIKit

protocol MovieDetailsView: AnyObject {
    func reloadData()
}

/// This flow MVP-Clean architectural pattern
class MovieDetailsViewController: BaseViewController {
    
    struct Constant {
        static let movieDetailsCellId = "MovieDetailsCollectionViewCell"
        static let moviePosterCellId = "MoviePosterCollectionViewCell"
        static let labelCellId = "LabelCollectionViewCell"
        static let screenTitle = "Movie Details"
    }
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.alwaysBounceVertical = true
            collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            collectionView.register(UINib(nibName: Constant.moviePosterCellId, bundle: nil), forCellWithReuseIdentifier: Constant.moviePosterCellId)
            collectionView.register(UINib(nibName: Constant.movieDetailsCellId, bundle: nil), forCellWithReuseIdentifier: Constant.movieDetailsCellId)
            collectionView.register(UINib(nibName: Constant.labelCellId, bundle: nil), forCellWithReuseIdentifier: Constant.labelCellId)
        }
    }
    
    var configurator: MovieDetailsConfigurator!
    private var presenter: MovieDetailsPresenter?
    private var router: MovieDetailsRouter?
    
    func inject(presenter: MovieDetailsPresenter, router: MovieDetailsRouter) {
        self.presenter = presenter
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let configurator = configurator {
            configurator.configure(viewController: self)
        }
        
        presenter?.fetchSimilarMovieList()
        collectionView.setCollectionViewLayout(makeLayout(), animated: true)
        setupNavigationBar()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.title = Constant.screenTitle
    }
    
}

extension MovieDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.numberOfSections ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let type = SectionType(rawValue: section) else { return 0 }
        return presenter?.items(at: type) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        guard let type = SectionType(rawValue: indexPath.section) else { return cell }
        
        switch type {
            
        case SectionType.movieDetails:
            
            guard let type = SectionType(rawValue: indexPath.section),
                let movie = presenter?.movie(at: type, item: indexPath.item) else {
                    return cell
            }
            if indexPath.item == 0 {
                guard let movieDetailsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.movieDetailsCellId, for: indexPath) as? MovieDetailsCollectionViewCell else {
                    return cell
                }
                movieDetailsCollectionViewCell.configureCell(with: movie)
                cell = movieDetailsCollectionViewCell
                
            }else {
                guard let labelCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.labelCellId, for: indexPath) as? LabelCollectionViewCell else {
                    return cell
                }
                labelCollectionViewCell.configureCell(with: movie)
                cell = labelCollectionViewCell
            }
            
        case SectionType.similarMovies:
            guard let moviePosterCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.moviePosterCellId, for: indexPath) as? MoviePosterCollectionViewCell,
                let type = SectionType(rawValue: indexPath.section),
                let movie = presenter?.movie(at: type, item: indexPath.item) else {
                    return UICollectionViewCell()
            }
            
            moviePosterCollectionViewCell.configureCell(with: movie)
            cell = moviePosterCollectionViewCell
        }
        
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let type = SectionType(rawValue: indexPath.section), let movie = presenter?.movie(at: type, item: indexPath.item) else { return }
        router?.pushMovieDetailsScreen(with: movie)
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionLayoutKind = SectionType(rawValue: section) else { return nil }
            let columns = sectionLayoutKind.numberOfColumns
            
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupHeight = columns == 1 ?
                NSCollectionLayoutDimension.absolute(180) :
                NSCollectionLayoutDimension.absolute(170)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
            return section
            
        }
        return layout
    }
    
}

extension MovieDetailsViewController: MovieDetailsView {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
