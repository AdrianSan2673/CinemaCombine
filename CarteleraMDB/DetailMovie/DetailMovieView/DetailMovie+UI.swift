//
//  DetailMovie+UI.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 30/03/24.
//

import Foundation
import UIKit

extension DetailMovieCombineView {
    func setupUI() {
        addSubViews()
        setupConstraint()
        navigationConfiguration()
    }
    
    func navigationConfiguration(){
        title = "Detail"
        navigationController?.navigationBar.tintColor = .black
    }
    
    func addSubViews(){
        [stackMain].forEach(view.addSubview)
        [imageMovie,titleLabel,stackRelase,labelGender,collectionGender,descriptionLabel].forEach(stackMain.addArrangedSubview)
        [dateLauncherLabel,rankedLabel].forEach(stackRelase.addArrangedSubview)
    }
    
    func setupConstraint(){
        NSLayoutConstraint.activate([
            stackMain.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackMain.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackMain.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackMain.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            imageMovie.leadingAnchor.constraint(equalTo: stackMain.leadingAnchor),
            imageMovie.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3),
            
            titleLabel.centerXAnchor.constraint(equalTo: stackMain.centerXAnchor),
            //titleLabel.bottomAnchor.constraint(equalTo: stackRelase.topAnchor),
            
            stackRelase.leadingAnchor.constraint(equalTo: stackMain.leadingAnchor, constant: 20),
            stackRelase.trailingAnchor.constraint(equalTo: stackMain.trailingAnchor, constant: -20),
            
            collectionGender.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionGender.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionGender.heightAnchor.constraint(equalToConstant: 20),
    
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
        ])
    }
}

