//
//  DetailViewController.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 15.01.2024.
//


import UIKit
import SDWebImage

protocol DetailViewControllerProtocol {
    var posterpath: String { get }
}

class DetailViewController: UIViewController {
    
    

    var movideId: Int?
    
    let viewModel = DetailViewModel()
    
    @IBOutlet weak var bigİmageView: UIImageView!
    @IBOutlet weak var smallİmageView: UIImageView!
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    func configure(data: DetailViewControllerProtocol) {
        bigİmageView.sd_setImage(with: URL(string: data.posterpath))
        smallİmageView.sd_setImage(with: URL(string: data.posterpath))
    
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movideId {
            viewModel.getMovieDetail(id: movideId)
            viewModel.succesCallback = {
                DispatchQueue.main.async {
                    if let movieDetail = self.viewModel.movieDetail {
                        self.configure(data: movieDetail)
                        self.configure(movieModel: movieDetail)
                    }
                    
                }
            }
        }
        
        
    }
    
   
    
    
    
    
    
    
    func configure(movieModel: MovieDetail) {
        filmTitle.text = movieModel.originalTitle
        yearLbl.text = movieModel.releaseDate
        timeLbl.text = "\(movieModel.runtime!)"
        descLbl.text = movieModel.overview
        if let genre = movieModel.genres?.first {
            typeLbl.text = genre.name
        }
    }
    
    
    
    
    @IBAction func castMovie(_ sender: Any) {
        
    }
    @IBAction func reviewsMovie(_ sender: Any) {
    }
    @IBAction func aboutMovie(_ sender: Any) {
    }
    
    
    
    
}
