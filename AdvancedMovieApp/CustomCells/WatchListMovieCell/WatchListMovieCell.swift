//
//  WatchListMovieCell.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 20.01.2024.
//

import UIKit
import SwipeCellKit
class WatchListMovieCell: SwipeCollectionViewCell {
    
   
   
    
    static let identifier = "WatchListMovieCell"
    
    

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configre(data: SaveMovie) {
        titleLabel.text = data.orginalTitle
        rateLabel.text = "\(data.voteAverage)"
        yearLabel.text = data.releaseDate
        movieImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original/\(data.posterPath ?? "")"))
        movieImage.layer.cornerRadius = 16
    }
}
