//
//  Router.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 07/06/2021.
//

import Foundation
import UIKit

enum StoryBoardName :String {
    case Main =  "Main"
    case Authentication = "Auth"
    case Payment =  "Payment"
    case LaunchScreen =  "LaunchScreen"
    
}

extension UIStoryboard{
    static func mainStoryBoard()-> UIStoryboard{
        return UIStoryboard(name: StoryBoardName.Main.rawValue, bundle: nil)
    }
    
    static func authStoryBoard()-> UIStoryboard{
        return UIStoryboard(name: StoryBoardName.Authentication.rawValue, bundle: nil)
    }
    
    static func paymentStoryBoard()-> UIStoryboard{
        return UIStoryboard(name: StoryBoardName.Payment.rawValue, bundle: nil)
    }
}

extension UIViewController{
    //MARK:- Route of AuthStoryBoard
    func navigateFormWelcomeScreenToAuthScreen(){
        guard let vc = UIStoryboard.authStoryBoard().instantiateViewController(identifier: AuthenticationViewController.identifier) as? AuthenticationViewController else{return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
      
    self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateFormAuthScreenToHomeScreen(){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: HomeViewController.identifier) as? HomeViewController else{return}
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen

       // present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
  
        
    }
    
    
    
    //MARK:- Home StoryBoard Navigation
    func navigateFormHomeToMovieDetailsScreen(movieId : Int){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: MovieDetailsViewController.identifier) as? MovieDetailsViewController else{return}
        vc.movieID = movieId
        self.navigationController?.pushViewController(vc, animated: true)
    
        
    }
    
    func navigateFormMovieDetailsScreenToDateChoosingScreen(movieId : Int,
                                                            movieName : String){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: DateViewController.identifier) as? DateViewController else{return}
        vc.movieID = movieId
        vc.movieName = movieName
        self.navigationController?.pushViewController(vc, animated: true)
  
        
    }
    
    func navigateFormDateChoosingScreenToSeatsChoosingScreen(
        movieId : Int,
        movieName : String,
        timeSlot : Timeslot,
        cinema : Cinema,
        bookingDate : Date){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: MovieSeatViewController.identifier) as? MovieSeatViewController else{return}
        
        vc.movieName = movieName
        vc.movieID = movieId
        vc.cinema = cinema
        vc.bookingDate = bookingDate
        vc.cinemaDayTimeslot = timeSlot
    
        self.navigationController?.pushViewController(vc, animated: true)
  
        
    }
    
    func navigateFormSeatsChoosingScreenToBillingScreen(
        totalPrice : Double,
        movieID : Int,
        timeSlot: Timeslot,
        cinema: Cinema,
        selectedSeats : [MovieSeatVO],
        bookingDate : Date?
    ){
        guard let vc = UIStoryboard.paymentStoryBoard().instantiateViewController(identifier: BillingScreenViewController.identifier) as? BillingScreenViewController else{return}
        vc.totalPrice = totalPrice
        vc.movieID = movieID
        vc.cinema = cinema
        vc.cinemaDayTimeslot = timeSlot
        vc.selectedSeats = selectedSeats
        vc.bookingDate = bookingDate
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func navigateFormHomeToLoginScreen(){
        guard let vc = UIStoryboard.authStoryBoard().instantiateViewController(identifier: WelcomeScreenViewController.identifier) as? WelcomeScreenViewController else{return}
        self.navigationController?.removeFromParent()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    //MARK:- Route of Payment StoryBoard
    func navigateFromBillingScreenToPaymentMethodScreen(
        totalPrice : Double,
        movieID : Int,
        timeSlot: Timeslot,
        cinema: Cinema,
        selectedSeats : [MovieSeatVO],
        selectedSnacks : [Snack],
        bookingDate : Date?
    ){
        guard let vc = UIStoryboard.paymentStoryBoard().instantiateViewController(identifier: PaymentMethodViewController.identifier) as? PaymentMethodViewController else{return}
        
        vc.totalPrice = totalPrice
        vc.movieID = movieID
        vc.cinema = cinema
        vc.cinemaDayTimeslot = timeSlot
        vc.selectedSeats = selectedSeats
        vc.bookingDate = bookingDate
        vc.selectedSnacks = selectedSnacks

        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func navigateFromPaymentMethodScreenToGettingTicketScreen(
       
        movieID : Int,
        cinema: Cinema,
        bookingDate : Date?,
        checkOutData  : CheckOutResponse
    ){
        guard let vc = UIStoryboard.paymentStoryBoard().instantiateViewController(identifier: GettingTicketViewController.identifier) as? GettingTicketViewController else{return}

        vc.cinema = cinema
        vc.movieID = movieID
        vc.bookingDate = bookingDate
        vc.checkOutData = checkOutData
        self.navigationController?.pushViewController(vc, animated: true)
      
    }
    
    func navigateFromGettingTicketScreenToHomeScreen(){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: HomeViewController.identifier) as? HomeViewController else{return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.navigationController?.pushViewController(vc,animated: true)
    }
    
   
}
//extension UICollectionViewCell{
//    func navigateFormAuthScreenToHomeScreen(){
//        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: HomeViewController.identifier) as? HomeViewController else{return}
//        vc.modalPresentationStyle = .fullScreen
//        vc.modalTransitionStyle = .flipHorizontal
//        present(vc,animated: true)
//        
//    }
//}

