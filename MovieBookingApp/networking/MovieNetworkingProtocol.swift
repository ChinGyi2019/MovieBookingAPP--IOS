//
//  MovieNetworkingProtocol.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 15/07/2021.
//

import Foundation
import Alamofire

protocol MovieNetworkingProtocol {
    
    
    
   //MARK:- Authentication
    func register(user : User, completion :  @escaping(NetworkResult<RegisterResponse>) ->Void)
    
    func loginWithEmail(user: User, completion: @escaping (NetworkResult<RegisterResponse>) -> Void)
    
    func loginWithGoogle(_ googleToken: String, completion: @escaping (NetworkResult<RegisterResponse>) -> Void)
    
    func loginWithFacebook(_ facebookToken: String, completion: @escaping (NetworkResult<RegisterResponse>) -> Void)
    
    func logOut(completion: @escaping (NetworkResult<LogOutResponse>) -> Void)
    
    func getProfile(completion: @escaping (NetworkResult<ProfileResponse>) -> Void)
    
    
    func fetchMovies(take: Int,status : String, completion: @escaping (NetworkResult<MovieListResponse>) -> Void)
    
    func fetchMovieDetails(movieId: Int, completion: @escaping (NetworkResult<MovieDetailsResponse>) -> Void)
    
    func fetchCinemaDayTimeSlot(movieId: Int,date : String, completion: @escaping (NetworkResult<CinemaDayTimeSlotResponse>) -> Void)
    
    func fetchCinemaSeatingPlan(bookingDate: String, timeSlotId: Int, completion: @escaping (NetworkResult<CinemaSeatingPlanResponse>) -> Void)
    
    func fetchSnackList(completion: @escaping (NetworkResult<SnackListResponse>) -> Void)
    
    func fetchPaymentMethods(completion: @escaping (NetworkResult<PaymentMethodListResponse>) -> Void)
    
    func addNewCard(card: Card, completion: @escaping (NetworkResult<AddNewCardResponse>) -> Void)
    
    func checkOut(checkOut: CheckOutModel, completion: @escaping (NetworkResult<CheckOutResponse>) -> Void)
    
    
}


