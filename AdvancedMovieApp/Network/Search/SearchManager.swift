//
//  SearchManager.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 16.01.2024.
//

import Foundation

protocol SearchManagerProtocol {
func getSearchMovies(query: String, complete: @escaping((MoviesModel?, Error?) -> ()))
}

class SearchManager: SearchManagerProtocol {
    static let sherad = SearchManager()
    
    func getSearchMovies(query: String, complete: @escaping ((MoviesModel?, Error?) -> ())) {
        let searchRequestUrl = NetworkHelper.sheard.requestSearchUrl(url: SearchHelper.search.rawValue, query: query)
        NetworkManager.shared.request(type: MoviesModel.self, url: searchRequestUrl, method: .get) { response in
            switch response {
            case .success(let data):
                complete(data, nil)
            case .failure(let error):
                print("Error in getUpcomingMovies: \(error)")
                complete(nil, error)
            }
        }
    }
}
