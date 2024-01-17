//
//  DetailManager.swift
//  AdvancedMovieApp
//
//  Created by Fatih on 15.01.2024.
//

import Foundation

class DetailManager {
    
    static let shared = DetailManager()
    
    func getMovieDetail(id: Int, completion: @escaping (MovieDetail?, Error?) -> ()) {
        let detailRequestUrl = NetworkHelper.sheard.requestDetailUrl(url: DetailEndPoint.detail.rawValue, id: id )
        print(detailRequestUrl)
        
        NetworkManager.shared.request(type: MovieDetail.self, url: detailRequestUrl, method: .get) { response in
            switch response {
            case .success(let data):
                completion(data, nil)
            case .failure(let failure):
                completion(nil, failure)
            }
        }
    }
}
