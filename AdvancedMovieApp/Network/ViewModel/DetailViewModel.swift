//
//  DetailViewModel.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 15.01.2024.
//

import Foundation

class DetailViewModel {
    let manager = DetailManager.shared
    var movieDetail: MovieDetail?
    var errorCallback: ((String)->())?
    var succesCallback: (()->())?
    
    
    func getMovieDetail(id: Int) {
        manager.getMovieDetail(id: id) { [weak self] movieDetail, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                
                self?.movieDetail = movieDetail
                self?.succesCallback?()
            }
        }
    }
}
