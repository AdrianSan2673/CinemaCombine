//
//  DetailMovieViewDelegate.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 17/06/24.
//

import Foundation
import UIKit

extension DetailMovieCombineView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numero de generos \(detailMovieViewModel.movieModel?.genres?.count)")
        return detailMovieViewModel.movieModel?.genres?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenderViewCell", for: indexPath) as? GenderViewCell else {
            return .init()
        }
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        let model = detailMovieViewModel.movieModel?.genres?[indexPath.row] ?? Genres(id: 1, name: "Familie")
        cell.configure(model: model)
        return cell
    }
}
