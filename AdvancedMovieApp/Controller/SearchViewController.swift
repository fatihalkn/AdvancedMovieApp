//
//  SearchViewController.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 16.01.2024.
//

import Foundation
import UIKit


class SearchViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var searchBarTextField: UITextField!
    
    var searchData: [MovieResult] = []
    let searcAPICaller = SearchManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegets()
        setupRegister()
        
        let imageIcon = UIImageView()
        imageIcon.image = UIImage(named: "Search1")
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "Search1")!.size.width, height: UIImage(named: "Search1")!.size.height)
        imageIcon.frame = CGRect(x: 5, y: 0, width: UIImage(named: "Search1")!.size.width, height: UIImage(named: "Search1")!.size.height)
        searchBarTextField.leftView = contentView
        searchBarTextField.leftViewMode = .always
        searchBarTextField.clearButtonMode = .whileEditing
        
    }
    
    
    
    
    
    
    func searchInAPI(query: String) {
        searcAPICaller.getSearchMovies(query: query) { [weak self] movie, error in
            if let error = error {
                
            } else {
                self?.searchData = movie?.results ?? []
                self?.mainTableView.reloadData()
            }
        }
    }
    
    
    func setupDelegets() {
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        searchBarTextField.delegate = self
    }
    
    func setupRegister() {
        mainTableView.register(UINib(nibName: HeaderCollectionCell.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderCollectionCell.identifier)
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCollectionCell.identifier, for: indexPath) as! HeaderCollectionCell
        if let movie = searchData[indexPath.row].title {
            cell.configure(data: movie as! HeaderCollectionCellProtocol)
            return UITableViewCell()
        }
        
        return cell
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text,
              let range = Range(range, in: currentText) else {
            return true
        }
        let updateText = currentText.replacingCharacters(in: range, with: string)
        
        searchInAPI(query: updateText)
        
        return true
    }
    
    
}
