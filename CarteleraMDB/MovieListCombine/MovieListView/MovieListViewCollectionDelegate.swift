//
//  MovieListViewCollectionDelegate.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 05/06/24.
//

import Foundation
import UIKit

extension MovieListCombineView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        loginViewModel.movieModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCell", for: indexPath) as? MovieListCell else {
            return .init()
        }
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        let model = loginViewModel.movieModel[indexPath.row]
        cell.configure(model: model)
        return cell
    }
}

extension MovieListCombineView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var detailMovieCombineView = DetailMovieCombineView()
        detailMovieCombineView.movieId = loginViewModel.movieModel[indexPath.row].id
        detailMovieCombineView.segmentControlIndexAux = segmentControl.selectedSegmentIndex
        detailMovieCombineView.loadingViewController = loadingViewController
        self.navigationController?.pushViewController(detailMovieCombineView, animated: true)
    }
    
}

extension MovieListCombineView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCellWidth - 10.0, height: 355.0)
    }
}

