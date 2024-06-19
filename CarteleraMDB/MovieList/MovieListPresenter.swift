//
//  MovieListPresenter.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 01/09/23.
//
import Foundation

protocol MovieListPresentable: AnyObject {
    var ui: ListOfMovieUI? {get}
    var viewModels: [MovieListViewModel] {get}
    
    func onViewAppear()
    func onTapCell(atIndex: Int)
}

protocol ListOfMovieUI: AnyObject {
    func update(movies: [MovieListViewModel])
}

class MovieListPresenter: MovieListPresentable {
    weak var ui: ListOfMovieUI?
    private let listOfMoviesInteractor: MovieListInteractable
    
    var viewModels: [MovieListViewModel] = []
    private var models: [MovieListEntity] = []
    private let mapper: Mapper
    private let router: MovieListRouting
    
    init(movieListInteractor: MovieListInteractable, mapper: Mapper = Mapper(), router: MovieListRouting) {
        self.listOfMoviesInteractor = movieListInteractor
        self.mapper = mapper
        self.router = router
    }
    
    func onViewAppear() {
        print("Estoy en el presenter")
        /*Task {
            models = await listOfMoviesInteractor.getListOfMoviesInteractor().result
            //viewModels = models.map(mapper.map(entity:))
            //ui?.update(movies: viewModels)
        }*/
    }
    
    func onTapCell(atIndex: Int) {
        let movieId = models[atIndex].title
    }

    func receiveData(_ data: Any) {
        print("hola soy el presenter: \(data)")
    }
}
