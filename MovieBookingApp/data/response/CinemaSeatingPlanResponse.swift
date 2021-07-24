//
//  CinemaSeatingPlanResponse.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 22/07/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieSeatingPlanResponse = try? newJSONDecoder().decode(MovieSeatingPlanResponse.self, from: jsonData)

import Foundation

// MARK: - CinemaSeatingPlanResponse
struct CinemaSeatingPlanResponse: Codable {
    let code: Int?
    let message: String?
    let data: [[MovieSeatVO]]?
    
    enum CodingKeys: String, CodingKey {
            case code, message,data
        }
    
}

//// MARK: - Datum
//struct Seatt: Codable {
//    let id: Int?
//    let type: SeatTypeEnum?
//    let seatName, symbol: String?
//    let price: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id, type
//        case seatName = "seat_name"
//        case symbol, price
//    }
//}


