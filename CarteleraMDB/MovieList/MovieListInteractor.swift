//
//  MovieListInteractor.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 01/09/23.
//

import Foundation

protocol MovieListInteractable: AnyObject {
    func getListOfMoviesInteractor() async -> PopularMovieResponseEntity
}

class MovieListInteractor: MovieListInteractable {
    
    var token = "6211d940adfd49ac181b6546b14ff89d"
    var baseURL = "https://api.themoviedb.org/3/movie/popular?api_key="
    
    func getListOfMoviesInteractor() async -> PopularMovieResponseEntity {
        let url = URL(string: baseURL + token)!
        let (data, _) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(PopularMovieResponseEntity.self, from: data)
    }

}
