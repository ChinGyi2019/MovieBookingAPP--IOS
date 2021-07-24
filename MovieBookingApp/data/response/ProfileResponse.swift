//
//  ProfileResponse.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 19/07/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let profileResponse = try? newJSONDecoder().decode(ProfileResponse.self, from: jsonData)

import Foundation

// MARK: - ProfileResponse
struct ProfileResponse: Codable {
    let code: Int?
    let message: String?
    let data: UserData?
    enum CodingKeys: String, CodingKey {
           case code, message, data
       }
    
}



