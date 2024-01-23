//
//  WatchListController.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 20.01.2024.
//

import Foundation
import UIKit
import SwipeCellKit

class WatchListController: UIViewController {
    
    var delegate: SwipeTableViewCellDelegate?
    private var watchListMovies: [SaveMovie] = [SaveMovie]()
    
    @IBOutlet weak var watchListCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRegister()
        setupDelegets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchLocalStorageForWatchList()
    }
    
    func setupRegister() {
        watchListCollection.register(UINib(nibName: WatchListMovieCell.identifier, bundle: nil), forCellWithReuseIdentifier: WatchListMovieCell.identifier)
    }
    func setupDelegets() {
        watchListCollection.delegate = self
        watchListCollection.dataSource = self
    }
    func fetchLocalStorageForWatchList() {
        DataManager.shared.fetchWatchListFromDataBase { result in
            switch result {
            case .success(let watchListMovies):
                self.watchListMovies = watchListMovies
                self.watchListCollection.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
extension WatchListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SwipeCollectionViewCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete from watchlist") { action, IndexPath in
            DataManager.shared.deleteWatchListWith(model: self.watchListMovies[indexPath.item]) {

                self.watchListMovies.remove(at: indexPath.item)
                self.watchListCollection.deleteItems(at: [IndexPath])
            }
        }
        deleteAction.image = UIImage(named: "delete")
        return [deleteAction]
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return watchListMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = watchListCollection.dequeueReusableCell(withReuseIdentifier: WatchListMovieCell.identifier, for: indexPath) as! WatchListMovieCell
        cell.configre(data: watchListMovies[indexPath.item])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let selectedMovieId = watchListMovies[indexPath.item].id
            if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                detailViewController.movideId = Int(selectedMovieId)
                detailViewController.modalTransitionStyle = .coverVertical
                navigationController?.pushViewController(detailViewController, animated: true)
            }
         }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width
        let cellHeight: CGFloat = 200
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
