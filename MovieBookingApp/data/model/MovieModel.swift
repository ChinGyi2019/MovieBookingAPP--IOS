//
//  MovieModel.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 26/07/2021.
//

import Foundation

protocol MovieModel {
    
    
    
    
    func fetchMovieDetails(movieId: Int, completion: @escaping (NetworkResult<MovieDetailsResponse>) -> Void)
}


class MovieModelImpl: BaseModel, MovieModel {
    
    static let shared  = MovieModelImpl()
    override init(){}
    func fetchMovieDetails(movieId: Int, completion: @escaping (NetworkResult<MovieDetailsResponse>) -> Void) {
        networkingAgent.fetchMovieDetails(movieId: movieId, completion: completion)
    }
    
    
}
