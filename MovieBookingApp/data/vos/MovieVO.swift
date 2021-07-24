//
//  MovieSeatVos.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 05/06/2021.
//

import Foundation


class MovieSeatVO : Codable{
    
    init(id : Int, type : SeatTypeEnum,
         seatName : String, symbol : String, price : Int) {
        self.id = id
        self.type = type
        self.symbol = symbol
        self.seatName = seatName
        self.price = price
    }
    let id: Int?
    let type: SeatTypeEnum?
    let seatName, symbol: String?
    let price: Int?
       
    func isSeatTypeAvailable() -> Bool {
        return type == .available
    }
    
    func isSeatTypeTaken() -> Bool {
        return type == .taken
    }
    func isSeatTypeText() -> Bool {
        return type == .text
    }
    func  isSpace() -> Bool {
        return type == .space
    }
    
    enum CodingKeys: String, CodingKey {
        case id, type
        case seatName = "seat_name"
        case symbol, price
    }
}

enum SeatTypeEnum: String, Codable {
    case available = "available"
    case space = "space"
    case taken = "taken"
    case text = "text"
}
