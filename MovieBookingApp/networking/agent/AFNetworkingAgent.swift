//
//  AFNetworkingAgent.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 15/07/2021.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

class AFNetworkingAgent: MovieNetworkingProtocol {
    
    //MARK: - Observable
    func fetchMovies(take: Int, status: String) -> Observable<MovieListResponse> {
        return RxAlamofire.requestDecodable(.get, MovieBookingEndPoint.movies(take, status))
            .flatMap { items -> Observable<MovieListResponse> in
                .just(items.1)
            }
    }
    
    func fetchMovieDetails(movieId: Int) -> Observable<MovieDetailsResponse> {
        return RxAlamofire.requestDecodable(.get, MovieBookingEndPoint.movieDetails(movieId))
            .flatMap { items -> Observable<MovieDetailsResponse> in
                .just(items.1)
            }
    }
    
    

    
    static var shared = AFNetworkingAgent()
    
    init() {}
    
    private var headers: HTTPHeaders {
        get{
            return [.authorization(bearerToken: UserDefaultHelper.shared.getToken())
            ]
        }
    }

    
    //MARK:- Authenticaiton
    func register(user: User, completion: @escaping (NetworkResult<RegisterResponse>) -> Void) {
        
        let userDict = [
            "name" : user.name,
            "email" : user.email,
            "phone" : user.phone,
            "password" : user.password,
            "google-access-token" : user.googleAccessToken,
            "facebook-access-token": user.facebookAccessToken
        ]
        
        let header : HTTPHeaders = [.accept("application/json")]
        
        AF.request("https://tmba.padc.com.mm/api/v1/register",
                   method: .post,
                   parameters: userDict,
                   headers: header)
            .validate(statusCode: 200 ..< 300)
            .responseDecodable(of: RegisterResponse.self)
            { response in
                switch response.result{
                
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let error): completion(.error(handleError(response, error, LoginCommonError.self)))
                    debugPrint("\(String(describing: error.underlyingError))")
                    
                }
                
            }
    }
    
    func loginWithEmail(user: User, completion: @escaping (NetworkResult<RegisterResponse>) -> Void) {
        
        let userDict = [
            "email" : user.email,
            "password" : user.password
        ]
        let header : HTTPHeaders = [.accept("application/json")]
        
        AF.request(MovieBookingEndPoint.login,
                   method: .post,
                   parameters: userDict,
                   headers: header
        )
        .validate(statusCode: 200 ..< 300)
        .responseDecodable(of: RegisterResponse.self)
        { response in
            switch response.result{
            
            case .success(let data):
                completion(.success(data))
                
            case .failure(let error): completion(.error(handleError(response, error, LoginCommonError.self)))
                
                debugPrint("Underling error \(String(describing: error.underlyingError))")
                
            }
            
        }
    }
    
    func loginWithGoogle(_ googleToken: String, completion: @escaping (NetworkResult<RegisterResponse>) -> Void) {
        
        let access_token = [
            "access-token" : googleToken
        ]
        let header : HTTPHeaders = [.accept("application/json")]
        
        AF.request(MovieBookingEndPoint.loginWithGoogle,
                   method: .post,
                   parameters: access_token,
                   headers: header)
            .validate(statusCode: 200 ..< 300)
            .responseDecodable(of: RegisterResponse.self)
            { response in
                switch response.result{
                
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let error): completion(.error(handleError(response, error, LoginCommonError.self)))
                    
                    debugPrint("Underling error \(String(describing: error.underlyingError))")
                    
                }
                
            }
    }
    
    func loginWithFacebook(_ facebookToken: String, completion: @escaping (NetworkResult<RegisterResponse>) -> Void) {
        let access_token = [
            "access-token" : facebookToken
        ]
        let header : HTTPHeaders = [.accept("application/json")]
        
        AF.request(MovieBookingEndPoint.loginWithFacebook,
                   method: .post,
                   parameters: access_token,
                   headers: header)
            .validate(statusCode: 200 ..< 300)
            .responseDecodable(of: RegisterResponse.self)
            { response in
                switch response.result{
                
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let error): completion(.error(handleError(response, error, LoginCommonError.self)))
                    
                    debugPrint("Underling error \(String(describing: error.underlyingError))")
                    
                }
                
            }
    }
    
    func logOut(completion: @escaping (NetworkResult<LogOutResponse>) -> Void) {
        
        AF.request(MovieBookingEndPoint.logout,
                   method: .post,
                   headers: headers)
            .validate(statusCode: 200 ..< 300)
            .responseDecodable(of: LogOutResponse.self)
            { response in
                switch response.result{
                
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let error): completion(.error(handleError(response, error, LoginCommonError.self)))
                    
                    debugPrint("Underling error \(String(describing: error.underlyingError))")
                    
                }
                
            }
    }
    
    //MARK:- Profile
    func getProfile(completion: @escaping (NetworkResult<ProfileResponse>) -> Void) {
        let header : HTTPHeaders = [.authorization(bearerToken: UserDefaultHelper.shared.getToken())
        ]
        AF.request(MovieBookingEndPoint.profile,
                   method: .get,
                   headers: header)
            .validate(statusCode: 200 ..< 300)
            .responseDecodable(of: ProfileResponse.self)
            { response in
                switch response.result{
                
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let error): completion(.error(handleError(response, error, LoginCommonError.self)))
                    
                    debugPrint("Underling error \(String(describing: error.underlyingError))")
                    
                }
                
            }
        
    }
    
    
    //MARK:- Movies
    func fetchMovies(take: Int,status : String, completion: @escaping (NetworkResult<MovieListResponse>) -> Void) {
        AF.request(MovieBookingEndPoint.movies(take, status),
                   method: .get)
            .validate(statusCode: 200 ..< 300)
            .responseDecodable(of: MovieListResponse.self)
            { response in
                switch response.result{
                
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let error): completion(.error(handleError(response, error, LoginCommonError.self)))
                    
                    debugPrint("Underling error \(String(describing: error.underlyingError))")
                    
                }
                
            }
        
    }
    func fetchMovieDetails(movieId: Int, completion: @escaping (NetworkResult<MovieDetailsResponse>) -> Void) {
        /*
         Test for CoreData Multi Task switch
         URLSession.shared.dataTask(with: MovieBookingEndPoint.movieDetails(movieId).url){data ,_,_ in
         
         completion(.success(try!  JSONDecoder().decode(MovieDetailsResponse.self, from: data!)))
         }.resume()
         */
        
        AF.request(MovieBookingEndPoint.movieDetails(movieId),
                   method: .get)
            .validate(statusCode: 200 ..< 300)
            .responseDecodable(of: MovieDetailsResponse.self)
            { response in
                switch response.result{
                
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let error): completion(.error(handleError(response, error, LoginCommonError.self)))
                    
                    debugPrint("Underling error \(String(describing: error.underlyingError))")
                    
                }
                
            }
    }
    
    func fetchCinemaDayTimeSlot(movieId: Int, date: String, completion: @escaping (NetworkResult<CinemaDayTimeSlotResponse>) -> Void) {
        AF.request(MovieBookingEndPoint.cinemaDayTimeSlot(movieId, date),method: .get,headers: headers)
            .validate(statusCode: 200 ..< 300)
            .responseDecodable(of: CinemaDayTimeSlotResponse.self)
            { response in
                switch response.result{
                
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let error): completion(.error(handleError(response, error, MDBCommonResponseError.self)))
                    
                    debugPrint("Underling error \(String(describing: error.underlyingError))")
                    
                }
                
            }
    }
    
    
    func fetchCinemaSeatingPlan(bookingDate: String, timeSlotId: Int, completion: @escaping (NetworkResult<CinemaSeatingPlanResponse>) -> Void) {
        AF.request(MovieBookingEndPoint.cinemaSetingPlan(timeSlotId, bookingDate),method: .get,headers: headers)
            .validate(statusCode: 200 ..< 300)
            .responseDecodable(of: CinemaSeatingPlanResponse.self)
            { response in
                switch response.result{
                
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let error): completion(.error(handleError(response, error, MDBCommonResponseError.self)))
                    
                    debugPrint("Underling error \(String(describing: error.underlyingError))")
                    
                }
                
            }
    }
    
    func fetchSnackList(completion: @escaping (NetworkResult<SnackListResponse>) -> Void) {
        AF.request(MovieBookingEndPoint.snacks,method: .get,headers: headers)
            .validate(statusCode: 200 ..< 300)
            .responseDecodable(of: SnackListResponse.self)
            { response in
                switch response.result{
                
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let error): completion(.error(handleError(response, error, MDBCommonResponseError.self)))
                    
                    debugPrint("Underling error \(String(describing: error.underlyingError))")
                    
                }
                
            }
    }
    
    func fetchPaymentMethods(completion: @escaping (NetworkResult<PaymentMethodListResponse>) -> Void){
        
        AF.request(MovieBookingEndPoint.paymentMethod,method: .get,headers: headers)
            .validate(statusCode: 200 ..< 300)
            .responseDecodable(of: PaymentMethodListResponse.self)
            { response in
                switch response.result{
                
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let error): completion(.error(handleError(response, error, MDBCommonResponseError.self)))
                    
                    debugPrint("Underling error \(String(describing: error.underlyingError))")
                    
                }
                
            }
    }
    
    func addNewCard(card: Card, completion: @escaping (NetworkResult<AddNewCardResponse>) -> Void) {
        
        
        AF.request(MovieBookingEndPoint.addNewCard,
                   method: .post, parameters: card,headers: headers)
            .validate(statusCode: 200 ..< 300)
            .responseDecodable(of: AddNewCardResponse.self)
            { response in
                switch response.result{
                
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let error): completion(.error(handleError(response, error, MDBCommonResponseError.self)))
                    
                    debugPrint("Underling error \(String(describing: error.underlyingError))")
                    
                }
                
            }
    }
    
    func checkOut(checkOut: CheckOutModel, completion: @escaping (NetworkResult<CheckOutResponse>) -> Void) {
        
        //header ,
        let headers : HTTPHeaders = [.authorization(bearerToken: UserDefaultHelper.shared.getToken()),
                                     .accept("application/json")]
        
        //Url Request
        let url = URL(string: AppConstants.BASE_URL.appending("/api/v1/checkout"))
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers = headers
        
        //Convert snacks to snackDict
        var snacksDict = [[String : Int]]()
        checkOut.snacks?.forEach({ snack in
            let signleSnack = ["id" : snack.id ?? 0,
                               "quantity" : snack.quantity]
            snacksDict.append(signleSnack)
        })
        //Body Raw Data
        let bodyData : [String :Any] = [
            "cinema_day_timeslot_id" : checkOut.cinemaDayTimeslotID ?? -1,
            "row" : checkOut.row ?? "",
            "seat_number" : checkOut.seatNumber ?? "",
            "booking_date" : checkOut.bookingDate ?? "",
            "total_price" : checkOut.totalPrice ?? 0.0,
            "movie_id" : checkOut.movieID ?? -1,
            "card_id" : checkOut.cardID ?? -1,
            "cinema_id" : checkOut.cinemaID ?? -1,
            "snacks" : snacksDict
            
            
        ]
        //Do BodyDict to Json Serialization
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyData)
        }catch{
            print("error json serialization")
        }
        //Send to Server
        AF.request(request)
            .validate(statusCode: 200 ..< 300)
            .responseDecodable(of: CheckOutResponse.self)
            { response in
                switch response.result{
                
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let error): completion(.error(handleError(response, error, CheckOutErrorModel.self)))
                    
                    debugPrint("Underling error \(String(describing: error.underlyingError))")
                    
                }
                
            }
    }
    
    
    
    
    
}

//MARK:- Handle Error

fileprivate func handleError<T,E: MDBErrorModel>(
    _ response : DataResponse<T, AFError>,
    _ error: (AFError),
    _ errorBodyType : E.Type) -> String {
    
    var respBody : String = ""
    
    var serverErrorMessage : String?
    
    var errorBody : E?
    
    if let respData = response.data{
        respBody = String(data: respData, encoding: .utf8) ?? "empty response Body"
        errorBody = try? JSONDecoder().decode(errorBodyType, from: respData)
        
        serverErrorMessage = errorBody?.message
        
    }
    /// 2 --- Extract debug info
    
    let respCode : Int = response.response?.statusCode ?? 0
    
    let sourcePath : String = response.request?.url?.absoluteString ?? "No URL"
    
    // 1 - Essential Debug info
    
    print("""
    =======================
    
    URL
    -> \(sourcePath)
    
    Status
    -> \(respCode)
    
    Body
    -> \(respBody)
    
    ServerErrorMessage
    -> \(String(describing: serverErrorMessage))
    
    UnderLyingError
    -> \(String(describing: error.underlyingError))
    
    Error Description
    -> \(String(describing: error.errorDescription))
    
    ========================
    """)
    
    
    return serverErrorMessage ?? error.errorDescription ?? "undified error :)"
}




protocol MDBErrorModel : Decodable{
    
    var message : String { get }
    
}



class MDBCommonResponseError : MDBErrorModel  {
    var message: String{
        return statusMessage
    }
    let statusMessage : String
    let error : String
    let statusCode : Int
    
    enum CodingKeys: String,CodingKey  {
        case statusMessage = "message"
        case error = "error"
        case statusCode = "code"
    }
}

// MARK: - LoginCommonError
struct LoginCommonError: Codable, MDBErrorModel {
    var message: String{
        if ((errors.phone?.isEmpty) == nil){
            return "\(errors.email?.first ?? "")"
        }else{
            return "\(errors.email?.first ?? "") & \(errors.phone?.first ?? "")"
        }
        
    }
    let statusMessage: String
    let errors: Errors
    enum CodingKeys: String,CodingKey  {
        case statusMessage = "message"
        case errors = "errors"
        
    }
    
}

// MARK: - Errors
struct Errors: Codable {
    let email: [String]?
    let phone: [String]?
    enum CodingKeys: String,CodingKey  {
        case email = "email"
        case phone = "phone"
        
    }
    
}
