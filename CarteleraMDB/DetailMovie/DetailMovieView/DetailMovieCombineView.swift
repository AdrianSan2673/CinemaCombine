//
//  DetailMovieCombineView.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 30/03/24.
//

import Foundation
import UIKit
import Combine

class DetailMovieCombineView: UIViewController {
    
    var movieId: Int?
    var segmentControlIndexAux: Int?
    
    // VARIABLES PARA COMBINE
    lazy var detailMovieViewModel = {
        return DetailMovieCombineViewModel(detailMovilNetwork: DetailMovilNetwork(), movieId: movieId ?? 0, segmentControlIndex: segmentControlIndexAux ?? 0)
    }()
    var cancellables = Set<AnyCancellable>()
    
    //VARIABLES LOCALES
    var loadingViewController: UILoadingModalViewController?
    
    lazy var stackMain: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var stackRelase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let imageMovie: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        label.text = "Detail movie"
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLauncherLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        label.text = "Detail movie"
        label.textColor = .green
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = false
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.white.cgColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rankedLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        label.text = "Detail movie"
        label.textColor = .green
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = false
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.white.cgColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        label.text = "Detail movie"
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelGender: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        label.text = "Gender"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionGender: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 90, height: 50)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        createBindingViewWithModel()
        collectionGender.register(GenderViewCell.self, forCellWithReuseIdentifier: "GenderViewCell")
        collectionGender.backgroundColor = .black
        openActivityIndicator()
        setupUI()
        collectionGender.dataSource = self
    }
    
    func createBindingViewWithModel(){
        detailMovieViewModel.reloadData.sink { _ in } receiveValue: { value in
            DispatchQueue.main.async {
                self.collectionGender.reloadData()
                self.imageMovie.kf.setImage(with: URL(string: Base_token.poster.rawValue + (value.imageURL ?? "nil")))
                if let title = value.title {
                    self.titleLabel.text = title
                } else {
                    self.titleLabel.text = value.name
                }
                if let release = value.releaseDate {
                    self.dateLauncherLabel.text = release
                } else {
                    self.dateLauncherLabel.text = value.firstAirDate
                }
                self.rankedLabel.text = "⭐️ \(value.votes ?? 0.0)"
                self.descriptionLabel.text = value.overview
                print(value.genres)
                self.dismissActivityIndicator()
            }
        }.store(in: &cancellables)
    }
    
    func openActivityIndicator() {
        loadingViewController = UILoadingModalViewController()
        let dialogInfo = UILoadingModalViewController.DialogInfo(title: "Loading...",description: "Fetch Movies Data")
        loadingViewController?.dialogInfo = dialogInfo
        loadingViewController?.providesPresentationContextTransitionStyle = true
        loadingViewController?.definesPresentationContext = true
        loadingViewController?.modalPresentationStyle = .overFullScreen
        loadingViewController?.modalTransitionStyle = .crossDissolve
        if let loadingViewController = self.loadingViewController{
            self.parent?.present(loadingViewController, animated: true)
        }
    }
    
    func dismissActivityIndicator(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
            if let loadingViewController = self.loadingViewController {
                loadingViewController.dismiss(animated: true, completion: nil)
                self.loadingViewController = nil
            }
        })
    }
}
