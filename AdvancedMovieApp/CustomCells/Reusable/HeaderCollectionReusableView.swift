//
//  HeaderCollectionReusableView.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 13.01.2024.
//

import UIKit

struct HomeTabData {
    let title: String
    let type: HomeTabType
}

enum HomeTabType {
    case popular
    case nowPlaying
    case upcoming
    case topRate
}

protocol HeaderCollectionReusableViewDelegate: AnyObject {
    func didSelectTab(type: HomeTabType)
    func didSelectMovie(movieId: Int)
}

class HeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var tabsCollectionView: UICollectionView!
    @IBOutlet weak var headerCollectionView: UICollectionView!
        
    let viewModel = HomeViewModel()
    
    let tabDatas: [HomeTabData] = [
        .init(title: "Now Playing", type: .nowPlaying),
        .init(title: "Popular", type: .popular),
        .init(title: "Upcoming", type: .upcoming),
        .init(title: "Top Rate", type: .topRate)
        ]
    
    static let identifier = "HeaderCollectionReusableView"
    
    var delegate: HeaderCollectionReusableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCel()
        setupDelegets()
        viewModelConfiguration()
    }

    fileprivate func viewModelConfiguration() {
        viewModel.getCategoryItems()
        viewModel.errorCallback = { errorMessage in
            
        }
        viewModel.succesCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.headerCollectionView.reloadData()
            }
            
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
            return viewModel.popularMovies?.results?.count ?? 0
            
        case tabsCollectionView:
            return tabDatas.count
        default:
            return .init()
            
        }
            
    }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            switch collectionView {
                
            case headerCollectionView:
                let cell = headerCollectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionCell.identifier, for: indexPath) as! HeaderCollectionCell
                if let movie = viewModel.popularMovies?.results?[indexPath.item] {
                    cell.configure(data: movie)
                }
                return cell
                
            case tabsCollectionView:
                let cell = tabsCollectionView.dequeueReusableCell(withReuseIdentifier: TabsCollectionViewCell.identifier, for: indexPath) as! TabsCollectionViewCell
                cell.tabTxtLbl.text = tabDatas[indexPath.item].title
                return cell
            default: return .init()
            }
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            switch collectionView {
                
                
            case headerCollectionView:
                headerCollectionView.deselectItem(at: indexPath, animated: true)
                if let selectedMovieId = viewModel.popularMovies?.results?[indexPath.item].id {
                    delegate?.didSelectMovie(movieId: selectedMovieId)
                }
            case tabsCollectionView:
                tabsCollectionView.deselectItem(at: indexPath, animated: true)
                let selectedTabType = tabDatas[indexPath.item].type
                delegate?.didSelectTab(type: selectedTabType)
                
            default:
                break
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            switch collectionView {
            case headerCollectionView:
                let cellWidth: CGFloat = (collectionView.frame.width - 40) / 2.5
                let cellHeight: CGFloat = collectionView.frame.height - 40
                return .init(width: cellWidth, height: cellHeight)
                
            case tabsCollectionView:
                let cellWidth: CGFloat = (collectionView.frame.width ) / 3.5
                let cellHeight: CGFloat = collectionView.frame.height
                return .init(width: cellWidth, height: cellHeight)
            default: return .init()
                
            }
            
        }
        
    }
    

