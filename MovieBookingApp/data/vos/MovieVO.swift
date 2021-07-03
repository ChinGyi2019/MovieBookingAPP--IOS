//
//  MovieSeatVos.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 05/06/2021.
//

import Foundation


struct MovieSeatVO {
        var title : String
        var type : String
       
    func isSeatTypeAvailable() -> Bool {
        return type == seat_type_available
    }
    
    func isSeatTypeTaken() -> Bool {
        return type == seat_type_taken
    }
    func isSeatTypeText() -> Bool {
        return type == seat_type_text
    }
}
