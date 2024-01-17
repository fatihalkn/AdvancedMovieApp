//
//  SearchTableViewCell.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 17.01.2024.
//

import UIKit

protocol tableViewCellProtocol {
    var poster_path: String { get }
}


class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    @IBOutlet weak var imgView: UIImageView!
    
    func configure(data: tableViewCellProtocol ) {
    imgView.sd_setImage(with: URL(string: data.poster_path))
}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
            
        }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
            // Configure the view for the selected state
        }
        
        
        
    }

