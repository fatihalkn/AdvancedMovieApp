// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movie = try? JSONDecoder().decode(Movie.self, from: jsonData)

import Foundation

// MARK: - Movie
struct MoviesModel: Codable {
    let page: Int?
    let results: [MovieResult]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case  page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieResult: Codable, HeaderCollectionCellProtocol, TableViewCellProtocol {
    var movieTitle: String {
        originalTitle ?? "Error Title"
    }
    
    var movieRate: Double {
        voteAverage ?? 0.0
    }
    
    var movieYear: String {
        releaseDate ?? "Error Year"
    }
    
    var poster_path: String {
        "https://image.tmdb.org/t/p/original\(posterPath ?? "")"
        
        
    }
    
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

