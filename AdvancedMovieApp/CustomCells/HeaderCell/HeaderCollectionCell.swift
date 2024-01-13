//
//  HeaderCollectionCell.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 13.01.2024.
//

import UIKit
import SDWebImage

protocol HeaderCollectionCellProtocol {
    var poster_path: String { get }
}

class HeaderCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    static let identifier = "HeaderCollectionCell"
    
    func configure(data: HeaderCollectionCellProtocol) {
        imgView.sd_setImage(with: URL(string: data.poster_path))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
}
