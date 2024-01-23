//
//  TabsCollectionViewCell.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 13.01.2024.
//

import UIKit

class TabsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TabsCollectionViewCell"
    
    @IBOutlet weak var tabTxtLbl: UILabel!
    
        override func awakeFromNib() {
        super.awakeFromNib()
        tabTxtLbl.layer.cornerRadius = 24
        tabTxtLbl.layer.masksToBounds = true
    }

}
