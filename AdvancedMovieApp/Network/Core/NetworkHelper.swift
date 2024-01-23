//
//  NetworkHelper.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 13.01.2024.
//

import Foundation

enum ErrorTypes: String, Error {
    case invalidData = "Invalid data"
    case invalidURL = "Invalid url"
    case generalError = "An error happend"
}

class NetworkHelper {
    static let sheard = NetworkHelper()
    private let baseURL = "https://api.themoviedb.org/3/"
    private let apiKey = "936011434e81730e4cef629bc41dbfb3"
    
    
    func requestUrl(url: String) -> String {
        baseURL + url + "?api_key=\(apiKey)"
    }
    
    func requestDetailUrl(url: String, id: Int) -> String {
        baseURL + url + "\(id)" + "?api_key=\(apiKey)"
    }
    
    func requestSearchUrl(url: String, query: String) -> String {
        baseURL + url + "\(query)"
    }
}

