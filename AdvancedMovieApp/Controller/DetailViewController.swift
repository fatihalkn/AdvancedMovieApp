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
    
 
    
    var savedMovies: [SaveMovie] = []
    
    
    @IBOutlet weak var bigİmageView: UIImageView!
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var watchListBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movideId {
            viewModel.getMovieDetail(id: movideId)
            viewModel.succesCallback = {
                DispatchQueue.main.async {
                    if let movieDetail = self.viewModel.movieDetail {
                        self.configure(movieModel: movieDetail)
                    }
                    
                }
            }
            
            DataManager.shared.fetchWatchListFromDataBase { result in
                switch result {
                case .success(let success):
                    self.savedMovies = success
                    if self.savedMovies.map({ $0.id }).contains(where: { $0 == movideId }) {
                        self.watchListBtn.tintColor = UIColor.red
                        print("Film Zaten Kaydedilmiş")
                    } else {
                        self.watchListBtn.tintColor = UIColor.white
                        print("Film Kayıtlı Değil")
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
            

        }
    }
    
    
        
        
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        
        
        
        
        sender.tintColor = sender.tintColor == UIColor.red ? UIColor.white : UIColor.red
        guard let movieDetail = viewModel.movieDetail  else { return }
        DataManager.shared.saveMovieDetailToCoreData(model: movieDetail) { result in
            switch result {
            case .success():
                print("Movie Detail Saved to CoreData")
            case .failure(_):
                print("Did occur error while saving Movie Detail")
            }
        }
    }
    
    
    
    
    
    
    
    func configure(movieModel: MovieDetail) {
        filmTitle.text = movieModel.title
        yearLbl.text = movieModel.releaseDate
        timeLbl.text = "\(movieModel.runtime ?? 0)"
        descLbl.text = movieModel.overview
        bigİmageView.sd_setImage(with: URL(string: movieModel.posterpath))
        if let genre = movieModel.genres?.first {
            typeLbl.text = genre.name
        }
    }
    
    
    

    
    
    
    
    
    
    
    
    
    
}
