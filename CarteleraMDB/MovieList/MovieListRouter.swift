//
//  MovieListRouter.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 01/09/23.
//

import Foundation
import UIKit

protocol MovieListRouting: AnyObject {
    //var detailRouter: DetailRouting? { get }
    //var listOfMovieView: MovieListViewController? { get }
    
    func showMovieList(fromViewViewController: UIViewController, userData: Userq)
    //func showDetailMovie(withMovieOf movie: String)
}

class MovieListRouter {
    var loginvVC = ViewController()
    
    //detailRouter = DetailRouter()
    //var listOfMovieView: MovieListViewController?
    
    /*func showMovieList(fromViewViewController: UIViewController, userData: Userq) {
        print("Entro l router")
        //let movieListInteractor = MovieListInteractor()
        //let movieListPresenter = MovieListPresenter(movieListInteractor: movieListInteractor, mapper: Mapper(), router: self)
        //let movieListView = MovieListViewController(presenter: movieListPresenter)
        //movieListPresenter.ui = movieListView
        //fromViewViewController.present(movieListView, animated: true)
    }*/
    
    //AQUI PODEMOS PONER LA FUNCION DEL LLAMADO PARA LA LISTA DE PRODUCTOS
}
extension MovieListRouter: MovieListRouting {
    func showMovieList(fromViewViewController: UIViewController, userData: Userq) {
        print("Entro l router")
    }
    
    
}
