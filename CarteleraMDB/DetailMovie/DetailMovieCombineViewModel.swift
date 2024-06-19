//
//  DetailMovieCombineViewModel.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 30/03/24.
//

import Foundation
import Combine

class DetailMovieCombineViewModel {
    @Published var showLoading = false
    @Published var errorMessage = ""
    var movieModel: CustomMultimediaEntity?
    var reloadData = PassthroughSubject<CustomMultimediaEntity, Error>()
    var cancellables = Set<AnyCancellable>()
    
    let detailMovilNetwork: DetailMovilNetwork
    let movieId: Int
    let segmentControlIndex: Int
    
    init(detailMovilNetwork: DetailMovilNetwork, movieId: Int, segmentControlIndex: Int){
        self.detailMovilNetwork = detailMovilNetwork
        self.movieId = movieId
        self.segmentControlIndex = segmentControlIndex
        getDetail(movieId: self.movieId, segmentControlIndex: self.segmentControlIndex)
    }
    
    func getDetail(movieId: Int, segmentControlIndex: Int) {
        errorMessage = ""
        showLoading = true
        switch segmentControlIndex {
        case 0,1:
            getDetailMovil(endPoint: EndPoint.detailMovie.rawValue, movieId: movieId)
        case 2,3:
            getDetailTv(endPoint: EndPoint.detailTv.rawValue, movieId: movieId)
        default:
            getDetailMovil(endPoint: EndPoint.detailMovie.rawValue, movieId: movieId)
        }
    }
    
    func getDetailMovil(endPoint: String, movieId: Int){
        Task {
            do {
                if let reciveData = try? await detailMovilNetwork.getDetailMovie(baseUrl: Base_token.baseURL.rawValue, endPoint: endPoint, movieID: movieId) {
                    movieModel = reciveData
                    reloadData.send(reciveData)
                } else {
                    errorMessage = "Failed to fetch data."
                }
            } catch let error as MovieError {
                errorMessage = error.localizedDescription
            }
            showLoading = false
        }
    }
    
    func getDetailTv(endPoint: String, movieId: Int){
        Task {
            do {
                if let reciveData = try? await detailMovilNetwork.getDetailMovie(baseUrl: Base_token.baseURL.rawValue, endPoint: endPoint, movieID: movieId) {
                    movieModel = reciveData
                    reloadData.send(reciveData)
                } else {
                    errorMessage = "Failed to fetch data."
                }
            } catch let error as MovieError {
                errorMessage = error.localizedDescription
            }
            showLoading = false
        }
    }
}
