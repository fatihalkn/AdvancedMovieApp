//
//  SearchTableViewCell.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 17.01.2024.
//

import UIKit

protocol TableViewCellProtocol {
    var poster_path: String { get }
    var movieTitle: String { get }
    var movieRate: Double { get }
    var movieYear: String { get }
    
}

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    
    @IBOutlet weak var movieYear: UILabel!
        
    func configure(data: TableViewCellProtocol ) {
        imgView.sd_setImage(with: URL(string: data.poster_path))
        movieTitle.text = data.movieTitle
        movieRate.text = "\(data.movieRate)"
        movieYear.text = data.movieYear
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

