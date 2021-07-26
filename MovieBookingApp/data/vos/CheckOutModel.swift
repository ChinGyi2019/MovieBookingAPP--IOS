//
//  CheckOutModel.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 24/07/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let checkOutModel = try? newJSONDecoder().decode(CheckOutModel.self, from: jsonData)

import Foundation

// MARK: - CheckOutModel
struct CheckOutModel: Codable {
    let cinemaDayTimeslotID: Int?
    let row, seatNumber, bookingDate: String?
    let  movieID, cardID, cinemaID: Int?
    let totalPrice : Double?
    let snacks: [CheckOutSnack]?

    enum CodingKeys: String, CodingKey {
        case cinemaDayTimeslotID = "cinema_day_timeslot_id"
        case row
        case seatNumber = "seat_number"
        case bookingDate = "booking_date"
        case totalPrice = "total_price"
        case movieID = "movie_id"
        case cardID = "card_id"
        case cinemaID = "cinema_id"
        case snacks
    }
}
//
//// MARK: - Snack
//struct Snack: Codable {
//    let id, quantity: Int?
//}
