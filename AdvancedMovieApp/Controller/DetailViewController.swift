//
//  DetailViewController.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 15.01.2024.
//


import UIKit
import SDWebImage
import CoreData

protocol DetailViewControllerProtocol {
    var posterpath: String { get }
}

class DetailViewController: UIViewController {
    
    
    
    var movideId: Int?
    
    let viewModel = DetailViewModel()
    
    @IBOutlet weak var bigİmageView: UIImageView!
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    func configure(data: MovieDetail) {
        bigİmageView.sd_setImage(with: URL(string: data.posterpath))

        
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
    
        @IBAction func saveButton(_ sender: UIButton) {
            if  let searhViewController = storyboard?.instantiateViewController(withIdentifier: SaveViewController.identifier) as? SaveViewController {
                searhViewController.modalTransitionStyle = .coverVertical
                navigationController?.pushViewController(searhViewController, animated: true)
            }
            
            
        }
    func configure(movieModel: MovieDetail) {
        filmTitle.text = movieModel.title
        yearLbl.text = movieModel.releaseDate
        timeLbl.text = "\(movieModel.runtime ?? 0)"
        descLbl.text = movieModel.overview
        if let genre = movieModel.genres?.first {
            typeLbl.text = genre.name
        }
    }
    
    
    

    
    
    
    
    
    
    
    
    
    
}
