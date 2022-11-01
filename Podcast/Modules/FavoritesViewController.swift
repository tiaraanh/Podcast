//
//  FavoritesViewController.swift
//  PodcastsApp
//
//  Created by Tiara H on 26/10/22.
//

import UIKit

class FavoritesViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = PodcastsViewModel()
    var favoritedPodcast: [Any] = []
    
    private let inset: CGFloat = 20
    private let spacing: CGFloat = 12
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoritedPodcast = viewModel.updateFavorite()
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loadFavorited()
    }
    
    func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        collectionViewLayout.minimumLineSpacing = spacing
        collectionViewLayout.minimumInteritemSpacing = spacing
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.backgroundColor = .clear
    }
    
    func loadFavorited() {
        let itemfavorited = viewModel.updateFavorite()
        favoritedPodcast = itemfavorited
    }
    
}

// MARK: - UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritedPodcast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCellId", for: indexPath) as! FavoriteViewCell
        
        let width = floor((UIScreen.main.bounds.width - (inset * 2) - spacing) / 2)
        cell.widthConstraint.constant = width
        cell.setNeedsLayout()

        let index = indexPath.row
        cell.artistLabel.text = (favoritedPodcast[index].self as AnyObject).artistsName
        cell.nameLabel.text = (favoritedPodcast[index].self as AnyObject).trackName
        cell.thubImageView.kf.setImage(with: URL(string: (favoritedPodcast[index].self as AnyObject).artwork)) {(result) in
            switch result {
            case.success:
                cell.thubImageView.contentMode = .scaleAspectFill
                
            case.failure:
                cell.thubImageView.contentMode = .center
                cell.thubImageView.image = UIImage(systemName: "photo")
                
            }
        }
            
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
    }
}


