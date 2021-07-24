//
//  AuthDelegate.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 28/06/2021.
//

import Foundation


protocol LoginDelegate {
    func didTabConfirmBtn()
    
    func loginShowError(message : String)
}

protocol SignDelegate {
    func didTapRegisterBtn(user : User)
    
    func signError(message : String)
}
