//
//  MovieModel.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 26/07/2021.
//

import Foundation
import RxSwift

protocol MovieModel {
    
    
    
    func fetchMovies(take: Int,status : MovieType, completion: @escaping (NetworkResult<[MovieResult]>) -> Void)
    
    
    func fetchMovieDetails(movieId: Int, completion: @escaping (NetworkResult<MovieDetails?>) -> Void)
    
    func fetchMovies(take: Int,status : MovieType) -> Observable <[MovieResult]>
    
    
    func fetchMovieDetails(movieId: Int) -> Observable<MovieDetails>
}


class MovieModelImpl: BaseModel, MovieModel {
    
    
    //MARK:- Obsevables
    func fetchMovies(take: Int, status: MovieType) -> Observable<[MovieResult]> {
        networkingAgent.fetchMovies(take: take, status: status.rawValue)
            .subscribe(onNext: { data in
                self.movieRepository.saveList(status: status, data: data.data ?? [MovieResult]())
            })
            
            .disposed(by: dispseBag)
        
        return movieRepository.getMovies(page: 1, take: take, type: status)
    }
    
    func fetchMovieDetails(movieId: Int) -> Observable<MovieDetails> {
        
        
//        return  networkingAgent.fetchMovieDetails(movieId: movieId)
//            .do(onNext: { data in
//                self.movieRepository.saveDetail(data: data.data)
//            })
//            .catchAndReturn(MovieDetailsResponse.empty())
//            .flatMap({ _ -> Observable<MovieDetails> in
//                self.movieRepository.getDetail(id: movieId)
//            })
        
        networkingAgent.fetchMovieDetails(movieId: movieId)
            .subscribe(onNext: { data in
                self.movieRepository.saveDetail(data: data.data)
            })

            .disposed(by: dispseBag)

        return movieRepository.getDetail(id: movieId)
        
    }
    
    
    static let shared  = MovieModelImpl()
    private let movieRepository = MovieRepositoryImpl.shared
    override init(){}
    
    func fetchMovieDetails(movieId: Int, completion: @escaping (NetworkResult<MovieDetails?>) -> Void){
        networkingAgent.fetchMovieDetails(movieId: movieId) { result in
            switch result {
            case .success(let data):
                self.movieRepository.saveDetail(data: data.data)
            case .error(let error):
                print("\(#function):\(error)")
                
            }
            
            self.movieRepository.getDetail(id: movieId){
                item  in
                if let item = item {
                    completion(.success(item))
                }else{
                    completion(.error("Cannot find Movie: \(movieId)"))
                }
            }
            
        }
        
        
        
    }
    //MARK-: SUCCESS 
    func fetchMovies(take: Int, status: MovieType, completion: @escaping (NetworkResult<[MovieResult]>) -> Void) {
        
        networkingAgent.fetchMovies(take: take, status: status.rawValue) { result in
            switch result {
            case .success(let data):
                self.movieRepository.saveList(status: status, data: data.data ?? [MovieResult]())
                
            case .error(let error):
                print("\(#function):\(error)")
            }
        }
        self.movieRepository.getMovies(page: 1, take: take, type: status) {
            completion(.success($0))
        }
        
    }
    
    
}
