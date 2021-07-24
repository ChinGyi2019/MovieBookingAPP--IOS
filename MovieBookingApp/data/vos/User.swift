//
//  User.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 17/07/2021.
//

import Foundation


struct User : Codable {
    
    var name : String? = nil
    var email : String?  = nil
    var phone : String? = nil
    var password : String? = nil
    var googleAccessToken : String? = nil
    var facebookAccessToken : String? = nil
    
}
