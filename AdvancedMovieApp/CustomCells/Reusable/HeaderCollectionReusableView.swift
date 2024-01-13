//
//  HeaderCollectionReusableView.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 13.01.2024.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var tabsCollectionView: UICollectionView!
    @IBOutlet weak var headerCollectionView: UICollectionView!
    
    let viewModel = HomeViewModel()
    
    let tabLbl = ["Now playing","Upcoming","Top rated","Popular"]
    
    static let identifier = "HeaderCollectionReusableView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCel()
        setupDelegets()
        viewModelConfiguration()
    }
    
    fileprivate func viewModelConfiguration() {
        viewModel.getCategoryItems()
        viewModel.errorCallback = { [weak self] errorMessage in
            print("error: \(errorMessage)")
        }
        viewModel.succesCallback = { [weak self] in
            self?.headerCollectionView.reloadData()
        }
    }
    
    func registerCel() {
        headerCollectionView.register(UINib(nibName: HeaderCollectionCell.identifier, bundle: nil), 
                                      forCellWithReuseIdentifier: HeaderCollectionCell.identifier)
        
        tabsCollectionView.register(UINib(nibName: TabsCollectionViewCell.identifier, bundle: nil),
                                    forCellWithReuseIdentifier: TabsCollectionViewCell.identifier)
        
    }
    
    func setupDelegets() {
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        
        tabsCollectionView.delegate = self
        tabsCollectionView.dataSource = self
        
    }
}
    
    extension HeaderCollectionReusableView:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case headerCollectionView:
            return viewModel.movie?.results?.count ?? 0
            
        case tabsCollectionView:
            return tabLbl.count
        default: return .init()
            
        }
            
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            switch collectionView {
                
            case headerCollectionView:
                let cell = headerCollectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionCell.identifier, for: indexPath) as! HeaderCollectionCell
                if let movie = viewModel.movie?.results?[indexPath.item] {
                    cell.configure(data: movie)
                }
                return cell
                
            case tabsCollectionView:
                let cell = tabsCollectionView.dequeueReusableCell(withReuseIdentifier: TabsCollectionViewCell.identifier, for: indexPath) as! TabsCollectionViewCell
                cell.tabTxtLbl.text = tabLbl[indexPath.item]
                return cell
            default: return .init()
            }
            
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            switch collectionView {
            case headerCollectionView:
                let cellWidth: CGFloat = (collectionView.frame.width - 40) / 2.5
                let cellHeight: CGFloat = collectionView.frame.height - 40
                return .init(width: cellWidth, height: cellHeight)
                
            case tabsCollectionView:
                let cellWidth: CGFloat = (collectionView.frame.width ) / 3
                let cellHeight: CGFloat = collectionView.frame.height
                return .init(width: cellWidth, height: cellHeight)
            default: return .init()
                
            }
            
        }
        
    }
    

