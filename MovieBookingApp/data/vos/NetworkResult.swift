//
//  NetworkResult.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 15/07/2021.
//

import Foundation

enum NetworkResult<T> {
    
    case success(T)
    
    case error(String)
}
