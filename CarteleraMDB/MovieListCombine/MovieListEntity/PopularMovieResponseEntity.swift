//
//  PopularMovieResponseEntity.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 30/03/24.
//

import Foundation

struct PopularMovieResponseEntity: Codable {
    let results: [CustomMultimediaEntity]
}
