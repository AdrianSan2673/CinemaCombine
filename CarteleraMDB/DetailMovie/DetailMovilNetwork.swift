//
//  DetailMovilNetwork.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 30/03/24.

import Foundation

final class DetailMovilNetwork {
    
    var isThereError: MovieError?
    var responseReturn: CustomMultimediaEntity?
    var utils = Utils()
    
    func getDetailMovie(baseUrl: String, endPoint: String, movieID: Int) async throws -> CustomMultimediaEntity {
        //Recupero la URl
        guard let url = URL(string: baseUrl + endPoint + String(movieID)) else {
            throw MovieError.invalidEndPoint
        }
        return try await withCheckedThrowingContinuation { continuation in
            utils.loadURLAndDecode(url: url) { (result: CustomMultimediaEntity?, error: MovieError? ) in
                if let data = result {
                    continuation.resume(returning: data)
                } else if let MovieError = error {
                    continuation.resume(throwing: MovieError)
                }
            }
        }
    }
}
