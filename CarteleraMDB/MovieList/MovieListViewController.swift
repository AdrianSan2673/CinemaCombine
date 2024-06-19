//
//  MovieListViewController.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 01/09/23.
//

import Foundation
import UIKit

protocol DetailPresenterUI: AnyObject {
    func updateUI(viewModel: MovieListViewModel)
}

class MovieListViewController: UIViewController {
    private let presenter: MovieListPresentable
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Estoy en el modulo de viper"
        label.numberOfLines = 0
        label.textColor = .red
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(presenter: MovieListPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setGradientBackground()
        [errorLabel].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setGradientBackground() {
        let colorTop2 =  UIColor(red: 13.0/255.0, green: 37.0/255.0, blue: 63.0/255.0, alpha: 5.0).cgColor
        let colorTop =  UIColor(red: 1.0/255.0, green: 180.0/255.0, blue: 228.0/255.0, alpha: 5.0).cgColor
        let colorBottom = UIColor(red: 144.0/255.0, green: 206.0/255.0, blue: 161.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop2,colorTop, colorBottom]
        gradientLayer.locations = [0.1,0.5, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}

extension MovieListViewController: ListOfMovieUI {
    func update(movies: [MovieListViewModel]) {
        print("Datos recibidos \(movies)")
    }
}
