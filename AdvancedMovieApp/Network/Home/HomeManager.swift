//
//  HomeManager.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 13.01.2024.
//

import Foundation

protocol HomeManagerProtocol {
    func getCategoryMovies(complete: @escaping((MoviesModel?, Error?) -> ()))
}

class HomeManager: HomeManagerProtocol {
    
    static let sheard = HomeManager()
    
    func getCategoryMovies(complete: @escaping ((MoviesModel?, Error?) -> ())) {
        let url = HomeEndpoint.popular.path
        
        NetworkManager.shared.request(type: MoviesModel.self, url: HomeEndpoint.popular.path, method: .get) { response in
            switch response {
            case .success(let data):
                complete(data, nil)
            case .failure(let error):
                complete(nil, error)
                
            }
        }
    }
}
