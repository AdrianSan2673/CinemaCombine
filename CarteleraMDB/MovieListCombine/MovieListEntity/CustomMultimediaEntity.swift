//
//  CustomMultimediaEntity.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 30/03/24.
//

import Foundation

struct CustomMultimediaEntity: Codable {
    var id: Int?
    var title: String?
    var overview: String?
    var imageURL: String?
    var votes: Double?
    var releaseDate: String?
    var genres: [Genres]?
    var originalName: String?
    var firstAirDate: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey{
        case id, title, overview, genres, name
        case imageURL = "poster_path"
        case votes = "vote_average"
        case releaseDate = "release_date"
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        
    }
}

struct Genres: Codable {
    var id: Int?
    var name: String?
}
