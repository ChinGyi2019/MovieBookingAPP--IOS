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
    //Route of AuthStoryBoard
    func navigateFormWelcomeScreenToAuthScreen(){
        guard let vc = UIStoryboard.authStoryBoard().instantiateViewController(identifier: AuthenticationViewController.identifier) as? AuthenticationViewController else{return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
    present(vc,animated: true)
        
    }
    
    func navigateFormAuthScreenToHomeScreen(){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: HomeViewController.identifier) as? HomeViewController else{return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
    present(vc,animated: true)
        
    }
    
    
    
    //Route of Home StoryBoard Navigation
    func navigateFormHomeToMovieDetailsScreen(){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: MovieDetailsViewController.identifier) as? MovieDetailsViewController else{return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
    present(vc,animated: true)
        
    }
    
    func navigateFormMovieDetailsScreenToDateChoosingScreen(){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: DateViewController.identifier) as? DateViewController else{return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
    present(vc,animated: true)
        
    }
    
    func navigateFormDateChoosingScreenToSeatsChoosingScreen(){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: MovieSeatViewController.identifier) as? MovieSeatViewController else{return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
    present(vc,animated: true)
        
    }
    
    func navigateFormSeatsChoosingScreenToBillingScreen(){
        guard let vc = UIStoryboard.paymentStoryBoard().instantiateViewController(identifier: PaymentMethodViewController.identifier) as? PaymentMethodViewController else{return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    //Route of Payment StoryBoard
    func navigateFromBillingScreenToPaymentMethodScreen(){
        guard let vc = UIStoryboard.paymentStoryBoard().instantiateViewController(identifier: PaymentMethodViewController.identifier) as? PaymentMethodViewController else{return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
    present(vc,animated: true)
    }
    
    func navigateFromPaymentMethodScreenToGettingTicketScreen(){
        guard let vc = UIStoryboard.paymentStoryBoard().instantiateViewController(identifier: GettingTicketViewController.identifier) as? GettingTicketViewController else{return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
    present(vc,animated: true)
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

