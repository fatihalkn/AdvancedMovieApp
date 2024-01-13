//
//  HomeHelper.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 13.01.2024.
//

import Foundation

enum HomeEndpoint: String {
    case popular = "movie/popular"
    
    
    var path: String {
        switch self {
        case .popular:
            return NetworkHelper.sheard.requestUrl(url: HomeEndpoint.popular.rawValue)
        }
    
    }
}
