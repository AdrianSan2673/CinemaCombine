//
//  MovieListCombineViewModel.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 30/03/24.
//
import Foundation
import Combine

class MovieListCombineViewModel {
    @Published var showLoading = false
    @Published var errorMessage = ""
    var movieModel: [CustomMultimediaEntity] = []
    var reloadData = PassthroughSubject<Void, Error>()
    var cancellables = Set<AnyCancellable>()
    
    let movieListNetwork: MovieListNetwork
    
    init(movieListNetwork: MovieListNetwork){
        self.movieListNetwork = movieListNetwork
        getMovieCatalogs()
    }
    
    func getMovieCatalogs(endPoint: String = EndPoint.movie.rawValue){
        errorMessage = ""
        showLoading = true
        Task {
            do {
                if let receiveData = try? await movieListNetwork.getCatalogsOf(baseUrl: Base_token.baseURL.rawValue, endPoint: endPoint) {
                    movieModel = receiveData
                    reloadData.send()
                } else {
                    errorMessage = "Failed to fetch data."
                }
            } catch let error as MovieError {
                errorMessage = error.localizedDescription
            }
            showLoading = false
        }
    }
}
