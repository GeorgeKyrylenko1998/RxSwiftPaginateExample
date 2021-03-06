// To parse the JSON, add this file to your project and do:
//
//   let films = try? newJSONDecoder().decode(Films.self, from: jsonData)

import Foundation

struct Films: Codable {
    let page, totalResults, totalPages: Int?
    let results: [Result]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

struct Result: Codable {
    
//    let voteCount, id: Int?
//    let video: Bool?
//    let voteAverage: Double?
    let title: String?
//    let popularity: Double?
    let posterPath: String?
//    let originalLanguage: OriginalLanguage?
//    let originalTitle: String?
//    let genreIDS: [Int]?
//    let backdropPath: String?
//    let adult: Bool?
    let overview: String?
//    , releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
//        case voteCount = "vote_count"
//        case id, video
//        case voteAverage = "vote_average"
        case title
        case posterPath = "poster_path"
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case genreIDS = "genre_ids"
//        case backdropPath = "backdrop_path"
        case overview
//        case releaseDate = "release_date"
    }
}
