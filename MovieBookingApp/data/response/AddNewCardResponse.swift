//
//  AddNewCardResponse.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 24/07/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let addNewCardResponse = try? newJSONDecoder().decode(AddNewCardResponse.self, from: jsonData)

import Foundation

// MARK: - AddNewCardResponse
struct AddNewCardResponse: Codable {
    let code: Int?
    let message: String?
    let data: [Card]?
}

// MARK: - Datum
//struct Datum: Codable {
//    let id: Int?
//    let cardHolder, cardNumber, expirationDate, cardType: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case cardHolder = "card_holder"
//        case cardNumber = "card_number"
//        case expirationDate = "expiration_date"
//        case cardType = "card_type"
//    }
//}
