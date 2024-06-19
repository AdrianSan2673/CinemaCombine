//
//  MovieListCombineView.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 30/03/24.

import Foundation
import UIKit
import Combine

class MovieListCombineView: UIViewController {
    
    //VARIABLES PARA COMBINE
    let loginViewModel = MovieListCombineViewModel(movieListNetwork: MovieListNetwork())
    var cancellables = Set<AnyCancellable>()
    
    //VARIABLES LOCALES
    var myCellWidth = UIScreen.main.bounds.width / 2
    
    var loadingViewController: UILoadingModalViewController?
    
    let movieCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 200, height: 200)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var segmentControl: UISegmentedControl = {
        var segmentedControl = UISegmentedControl(items: ["Popular","Top Rated","On TV","Airing Today"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .gray
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(selectGenderMovie), for: .valueChanged)
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // llama a crear el Binding
        createBindingViewWithModel()
        title = "TV Shows"
        
        let containView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 50, y: 10, width: 20, height: 20))
        imageView.image = UIImage(named: "clilpart")
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: containView)
        self.view.backgroundColor = .black
        movieCollection.register(MovieListCell.self, forCellWithReuseIdentifier: "MovieListCell")
        movieCollection.backgroundColor = .black
        
        containView.addSubview(imageView)

        setupUI()
        movieCollection.dataSource = self
        movieCollection.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithTransparentBackground()
            navBarAppearance.backgroundColor = .gray
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        
        let bar = navigationController?.navigationBar
        bar?.isTranslucent = true
        bar?.barTintColor = .gray
        bar?.backgroundColor = .gray
        bar?.standardAppearance.backgroundEffect = nil
    }
    
    @objc private func openMenu(){
        //self.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
    
    func createBindingViewWithModel() {
        loginViewModel.reloadData.sink { _ in } receiveValue: { _ in
            DispatchQueue.main.async {
                self.movieCollection.reloadData()
            }
        }.store(in: &cancellables)
    }
    
    @objc func selectGenderMovie() {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            loginViewModel.getMovieCatalogs(endPoint: EndPoint.movie.rawValue)
        case 1:
            loginViewModel.getMovieCatalogs(endPoint: EndPoint.topRanked.rawValue)
        case 2:
            loginViewModel.getMovieCatalogs(endPoint: EndPoint.onTheAir.rawValue)
        case 3:
            loginViewModel.getMovieCatalogs(endPoint: EndPoint.airingToday.rawValue)
        default:
            loginViewModel.getMovieCatalogs(endPoint: EndPoint.movie.rawValue)
        }
    }
}

