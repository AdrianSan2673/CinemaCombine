//
//  MovieListNetwork.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 30/03/24.

import Foundation

final class MovieListNetwork {
   
    var isThereError: MovieError?
    var responseReturn: [CustomMultimediaEntity]?
    var utils = Utils()
    
    func getCatalogsOf(baseUrl: String, endPoint: String) async throws -> [CustomMultimediaEntity] {
        //Recupero la URL
        guard let url = URL(string: baseUrl + endPoint) else {
            throw MovieError.invalidEndPoint
        }
        return try await withCheckedThrowingContinuation { continuation in
            utils.loadURLAndDecode(url: url) { (result: PopularMovieResponseEntity?, error : MovieError?) in
                if let data = result?.results {
                    continuation.resume(returning: .init(data))
                } else if let movieError = error {
                    continuation.resume(throwing: movieError)
                }
            }
        }
    }
}


