//
//  CheckOutError.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 26/07/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let checkOutError = try? newJSONDecoder().decode(CheckOutError.self, from: jsonData)

import Foundation

// MARK: - CheckOutError
struct CheckOutErrorModel: Codable, MDBErrorModel{
    var message: String{
        return statusMessage
    }
    
    let statusMessage: String
    let errors: CheckOutError?
    enum CodingKeys: String, CodingKey {
        case statusMessage = "message"
        case errors
    }
    
}

// MARK: - Errors
struct CheckOutError: Codable {
    let seatNumber: [String]?

    enum CodingKeys: String, CodingKey {
        case seatNumber = "seat_number"
    }
}
