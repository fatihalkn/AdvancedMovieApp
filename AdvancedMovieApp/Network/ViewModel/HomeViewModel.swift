//
//  HomeViewModel.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 13.01.2024.
//

import Foundation

class HomeViewModel {
    let manager = HomeManager.sheard
    
    var movie: MoviesModel?
    var errorCallback: ((String)->())?
    var succesCallback: (()->())?
    
    func getCategoryItems() {
        manager.getCategoryMovies { [weak self] movie, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                self?.movie = movie
                self?.succesCallback?()
            }
            
        }
    }
    
}
