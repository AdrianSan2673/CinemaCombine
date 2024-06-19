//
//  MovieListCell.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 30/03/24.
//

import Foundation
import UIKit
import SwiftUI
import Kingfisher

class MovieListCell: UICollectionViewCell {
    
    let myColor = UIColor(hex: 0x0B5345)
    
    let imageViewMovie: UIImageView = {
        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleMovie: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .green
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLauncher: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .green
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rankedLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .green
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionMovie: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 5
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = myColor
        [imageViewMovie,titleMovie,descriptionMovie,dateLauncher,rankedLabel].forEach(addSubview)
        NSLayoutConstraint.activate([
            imageViewMovie.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageViewMovie.topAnchor.constraint(equalTo: topAnchor),
            imageViewMovie.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageViewMovie.heightAnchor.constraint(equalToConstant: 215),
            
            titleMovie.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleMovie.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1),
            titleMovie.topAnchor.constraint(equalTo: imageViewMovie.bottomAnchor, constant: 15),
            titleMovie.heightAnchor.constraint(equalToConstant: 12.5),
            
            dateLauncher.topAnchor.constraint(equalTo: titleMovie.bottomAnchor, constant: 3),
            dateLauncher.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dateLauncher.trailingAnchor.constraint(equalTo: rankedLabel.leadingAnchor,constant: 10),
            dateLauncher.heightAnchor.constraint(equalToConstant: 12.5),
          
            rankedLabel.topAnchor.constraint(equalTo: titleMovie.bottomAnchor, constant: 3),
            rankedLabel.leadingAnchor.constraint(equalTo: dateLauncher.trailingAnchor, constant: 30),
            rankedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            dateLauncher.heightAnchor.constraint(equalToConstant: 12.5),
            
            descriptionMovie.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionMovie.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            descriptionMovie.topAnchor.constraint(equalTo: dateLauncher.bottomAnchor, constant: 4),
            descriptionMovie.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(model: CustomMultimediaEntity) {
        imageViewMovie.kf.setImage(with: URL(string: Base_token.poster.rawValue + (model.imageURL ?? "nil")))
        titleMovie.text = model.title ?? model.originalName
        dateLauncher.text = model.releaseDate ?? model.firstAirDate
        rankedLabel.text = "⭐️\(model.votes ?? 0.0)"
        descriptionMovie.text = model.overview
    }
}
