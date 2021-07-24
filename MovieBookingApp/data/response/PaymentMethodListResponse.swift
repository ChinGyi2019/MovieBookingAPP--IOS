//
//  PaymentMethodListResponse.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 23/07/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let paymentMethodListResponse = try? newJSONDecoder().decode(PaymentMethodListResponse.self, from: jsonData)

import Foundation

// MARK: - PaymentMethodListResponse
struct PaymentMethodListResponse: Codable {
    let code: Int?
    let message: String?
    let data: [PaymentMethod]?
}

// MARK: - Datum
struct PaymentMethod: Codable {
    let id: Int?
    let name, datumDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
    }
}
