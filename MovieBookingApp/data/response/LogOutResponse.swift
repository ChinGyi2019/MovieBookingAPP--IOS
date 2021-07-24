//
//  LogOutResponse.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 19/07/2021.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let logOutResponse = try? newJSONDecoder().decode(LogOutResponse.self, from: jsonData)

import Foundation

// MARK: - LogOutResponse
struct LogOutResponse: Codable {
    let code: Int?
    let message: String?
}
