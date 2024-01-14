//
//  HomeHelper.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 13.01.2024.
//

import Foundation

enum HomeEndpoint: String {
    case popular = "movie/popular"
    case nowPlaying = "movie/now_playing"
    case upcoming = "movie/upcoming"
    case topRate = "movie/top_rated"
    
    var path: String {
        switch self {
        case .popular:
            return NetworkHelper.sheard.requestUrl(url: HomeEndpoint.popular.rawValue)
        case .nowPlaying:
            return NetworkHelper.sheard.requestUrl(url: HomeEndpoint.nowPlaying.rawValue)
        case .upcoming:
           return NetworkHelper.sheard.requestUrl(url: HomeEndpoint.upcoming.rawValue)
        case .topRate:
           return NetworkHelper.sheard.requestUrl(url: HomeEndpoint.topRate.rawValue)
        }
    
    }
}
