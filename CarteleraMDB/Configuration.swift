//
//  Configuration.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 18/06/24.
//

import Foundation

enum MovieError: Error{
    case apiError
    case invalidEndPoint
    case invalidResponse
    case noData
    case serializationError
    case typeMismatch
    case keyNotFound
    case valueNotFound
    
    var localizedDescription: String{
        switch self {
        case .apiError: return "Failed to Fetch data"
        case .invalidEndPoint: return "Invalid End Point"
        case .invalidResponse: return "Invalid Response"
        case .noData: return "No data"

        case .serializationError: return "Failed to decode data"
        case .typeMismatch: return "Type mismatch error"
        case .keyNotFound: return "Key not found error"
        case .valueNotFound: return "valueNotFound"
        }
    }
    var errorUserInfo: [String: Any]{
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}

enum EndPoint: String {
    case movie = "/3/movie/popular?"
    case topRanked = "/3/movie/top_rated?"
    case airingToday = "/3/tv/airing_today?"
    case onTheAir = "/3/tv/on_the_air?"
    case detailMovie = "/3/movie/"
    case detailTv = "/3/tv/"
}

enum Base_token: String {
    case token = "6211d940adfd49ac181b6546b14ff89d"
                       // 6211d940adfd49ac181b6546b14ff89d
    case baseURL = "https://api.themoviedb.org"
    case AccessToke = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MjExZDk0MGFkZmQ0OWFjMTgxYjY1NDZiMTRmZjg5ZCIsInN1YiI6IjYyZmMzMTJjMTJhYWJjMDA4NGQwY2ZmOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vZeIxmvdoxYjSqeVyp6aNX1Il9DlQaAk4Ktrj8TA5oA"
    case poster = "https://image.tmdb.org/t/p/w500"
}

enum Result<T> {
    case success(T)
    case failure(MovieError)
}

enum optionResult: String{
    case results = "results"
}
