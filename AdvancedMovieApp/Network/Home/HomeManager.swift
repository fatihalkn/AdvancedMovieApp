//
//  HomeManager.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 13.01.2024.
//

import Foundation

protocol HomeManagerProtocol {
    func getPopularMovies(complete: @escaping((MoviesModel?, Error?) -> ()))
    func getNowPlayingMovies(complete: @escaping((MoviesModel?, Error?) -> ()))
    func getUpcomingMovies(complete: @escaping((MoviesModel?, Error?) -> ()))
    func getTopRateMovies(complete: @escaping((MoviesModel?, Error?) -> ()))

}

class HomeManager: HomeManagerProtocol {
    
    static let sheard = HomeManager()
    
    func getTopRateMovies(complete: @escaping ((MoviesModel?, Error?) -> ())) {
        NetworkManager.shared.request(type: MoviesModel.self, url: HomeEndpoint.topRate.path, method: .get) { response in
            switch response {
            case .success(let data):
                complete(data, nil)
            case .failure(let error):
                print("Error in getUpcomingMovies: \(error)")
                complete(nil, error)
                
                
            }
        }
    }
    
    
    
    
    func getUpcomingMovies(complete: @escaping ((MoviesModel?, Error?) -> ())) {
        NetworkManager.shared.request(type: MoviesModel.self, url: HomeEndpoint.upcoming.path, method: .get) { response in
            switch response {
            case .success(let data):
                complete(data, nil)
            case .failure(let error):
                print("Error in getUpcomingMovies: \(error)")
                complete(nil, error)
                
                
            }
        }
    }
    
    
  
    
    func getNowPlayingMovies(complete: @escaping ((MoviesModel?, Error?) -> ())) {
        NetworkManager.shared.request(type: MoviesModel.self, url: HomeEndpoint.nowPlaying.path, method: .get) { response in
            switch response {
            case .success(let data):
                complete(data, nil)
            case .failure(let error):
                complete(nil, error)
                
            }
        }
    }
    
    func getPopularMovies(complete: @escaping ((MoviesModel?, Error?) -> ())) {
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
