//
//  MovieListCombineView+UI.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 05/06/24.
//

import Foundation
import UIKit

extension MovieListCombineView {
    func setupUI(){
        addSubViews()
        configureConstraint()
    }
    
    func addSubViews(){
        [movieCollection, segmentControl].forEach(view.addSubview)
    }
    
    func configureConstraint(){
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            //segmentedControlContainerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 12),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -12),
            //segmentedControlContainerView.bottomAnchor.constraint(equalTo: movieCollection.topAnchor),
            segmentControl.heightAnchor.constraint(equalToConstant: 25),
            
            movieCollection.topAnchor.constraint(equalTo: segmentControl.bottomAnchor,constant: 22),
            movieCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
