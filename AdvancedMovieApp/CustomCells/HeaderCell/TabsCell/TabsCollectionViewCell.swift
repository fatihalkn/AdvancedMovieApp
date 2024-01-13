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
    
    static let tabLbl = ["Now playing","Upcoming","Top rated","Popular"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
