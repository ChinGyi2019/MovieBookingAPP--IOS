//
//  MovieBookingEndpoint.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 17/07/2021.
//


import Foundation
import Alamofire

enum MovieBookingEndPoint : URLConvertible{
    
    
    
    case register
    case login
    case loginWithGoogle
    case loginWithFacebook
    case logout
    case profile
    case movies(_ take : Int, _ status : String)
    case movieDetails(_ id : Int)
    case cinemaDayTimeSlot(_ movieId : Int,_ date : String)
    case cinemaSetingPlan(_ timeSlotId : Int,_ bookingDate : String)
    case snacks
    case paymentMethod
    case addNewCard
    case checkOut
    case actorCombinedCredits(_ id : Int)
    case searchMovie(_ query : String,_ page : Int)
    
    private var token : String{
        return UserDefaultHelper.shared.getToken()
    }
    
    func asURL() throws -> URL {
        return url
    }
    private var baseURL : String{
        return AppConstants.BASE_URL
    }
    
    var url :  URL{
        let urlComponent = NSURLComponents (string: baseURL.appending(apiPath))
        if urlComponent?.queryItems == nil{
            urlComponent?.queryItems = []
        }


//            urlComponent?.queryItems?.append(contentsOf: [URLQueryItem(name: "Barer ", value: token)])

        return urlComponent!.url!
    }
    
    private var apiPath : String{
        switch self {
    
            
        case .register: return "/api/v1/register"
            
        case .login: return "/api/v1/email-login"
            
        case .loginWithGoogle:
            return "/api/v1/google-login"
        case .loginWithFacebook:
            return "/api/v1/facebook-login"
            
        case .logout:
            return "/api/v1/logout"
            
        case .profile:
            return "/api/v1/profile"
        case .movies(let take, let status):
            return "/api/v1/movies?status=\(status)&take=\(take)"
        case .movieDetails(let id):
            return "/api/v1/movies/\(id)"
        case .cinemaDayTimeSlot(let movieId, let date):
            return  "/api/v1/cinema-day-timeslots?date=\(date)&movie_id=\(movieId)"
        case .snacks:
            return "/api/v1/snacks"
        case .paymentMethod:
            return "/api/v1/payment-methods"
        case .addNewCard:
            return "/api/v1/card"
        case .checkOut:
            return "/api/v1/checkout"
        case .actorCombinedCredits(let id):
            return "/person/\(id)/combined_credits"
            
        case .searchMovie(_, let page):
            return "/search/movie?page=\(page)"

        case .cinemaSetingPlan(let timeSlotId, let bookingDate):
            return "/api/v1/seat-plan?cinema_day_timeslot_id=\(timeSlotId)&booking_date=\(bookingDate)"
        }
    }
}
