

import UIKit

class HomeMainViewController: UIViewController {
    @IBOutlet weak var searchBar: UITextField!
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Created SearchBar
        
        
                let imageIcon = UIImageView()
                imageIcon.image = UIImage(named: "Search1")
                let contentView = UIView()
                contentView.addSubview(imageIcon)
                contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "Search1")!.size.width, height: UIImage(named: "Search1")!.size.height)
                imageIcon.frame = CGRect(x: 5, y: 0, width: UIImage(named: "Search1")!.size.width, height: UIImage(named: "Search1")!.size.height)
                searchBar.leftView = contentView
                searchBar.leftViewMode = .always
                searchBar.clearButtonMode = .whileEditing
        
        
        //MARK: - Func Call
        setupRegister()
        setupDelegets()
        viewModelConfiguration()
    }
    
    fileprivate func viewModelConfiguration() {
        viewModel.getNowPlayingMovies()
        viewModel.errorCallback = { [weak self] errorMessage in
            print("error: \(errorMessage)")
        }
        viewModel.succesCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.mainCollectionView.reloadData()
            }
            
        }
    }
    
    
    func setupRegister() {
        mainCollectionView.register(
            UINib(nibName: HeaderCollectionReusableView.identifier, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        mainCollectionView.register(
            UINib(nibName: TabsCollectionViewCell.identifier, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TabsCollectionViewCell.identifier)
        
        mainCollectionView.register(UINib(nibName: HeaderCollectionCell.identifier, bundle: nil),
                                    forCellWithReuseIdentifier: HeaderCollectionCell.identifier)
        
        mainCollectionView.register(UINib(nibName: TabsCollectionViewCell.identifier, bundle: nil),
                                    forCellWithReuseIdentifier: TabsCollectionViewCell.identifier)
    }
    
    func setupDelegets() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
    }
}

extension HomeMainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            switch collectionView {
            case mainCollectionView:
                let header = mainCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
                header.delegate = self
                return header
                
            default: return.init()
                
            }
        default: return.init()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerWidth = collectionView.frame.width
        let headerHeight = collectionView.frame.height * 0.35
        return .init(width: headerWidth, height: headerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return viewModel.categoryMovies?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionCell.identifier, for: indexPath) as! HeaderCollectionCell
        if let movie = viewModel.categoryMovies?.results?[indexPath.item] {
            cell.configure(data: movie)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case mainCollectionView:
            let cellWidth: CGFloat = (collectionView.frame.width - 60) / 3
            let cellHeight: CGFloat = cellWidth * 1.65
            return .init(width: cellWidth, height: cellHeight)
        default: return .init()
            
        }
        
    }
    
    
}

//MARK: - HeaderCollectionReusableViewDelegate
extension HomeMainViewController: HeaderCollectionReusableViewDelegate {
    func didSelectTab(type: HomeTabType) {
        switch type {
        case .popular:
            viewModel.getPopularMovies()
        case .nowPlaying:
            viewModel.getNowPlayingMovies()
        case .upcoming:
            viewModel.getUpcomingMovies()
        case .topRate:
            viewModel.getTopRateMovies()
        }
    }
    
    
}
