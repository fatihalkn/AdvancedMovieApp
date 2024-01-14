//
//  HomeViewModel.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 13.01.2024.
//

import Foundation

class HomeViewModel {
    let manager = HomeManager.sheard
    
    var popularMovies: MoviesModel?
    var categoryMovies: MoviesModel?
    var errorCallback: ((String)->())?
    var succesCallback: (()->())?
    
    func getCategoryItems() {
        manager.getPopularMovies { [weak self] movie, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                self?.popularMovies = movie
                self?.succesCallback?()
            }
            
        }
    }
    
    func getNowPlayingMovies() {
        manager.getNowPlayingMovies { [weak self] movie, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                self?.categoryMovies = movie
                self?.succesCallback?()
            }
            
        }
    }
    
    func getPopularMovies() {
        manager.getPopularMovies { [weak self] movie, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                self?.categoryMovies = movie
                self?.succesCallback?()
            }
            
        }
    }
    func getUpcomingMovies() {
        manager.getUpcomingMovies { [weak self] movie, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                self?.categoryMovies = movie
                self?.succesCallback?()
                
            }
            
        }
    }

    func getTopRateMovies() {
        manager.getTopRateMovies { [weak self] movie, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                self?.categoryMovies = movie
                self?.succesCallback?()
                
            }
            
        }
    }
    
}
