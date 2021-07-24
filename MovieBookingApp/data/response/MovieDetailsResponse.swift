//
//  MovieDetailsResponse.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 19/07/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieDetailsResponse = try? newJSONDecoder().decode(MovieDetailsResponse.self, from: jsonData)

import Foundation

// MARK: - MovieDetailsResponse
struct MovieDetailsResponse: Codable {
    let code: Int?
    let message: String?
    let data: MovieDetails?
    
    enum CodingKeys: String, CodingKey {
        case code, message, data
    }
}

// MARK: - MovieResult

struct MovieDetails: Codable {
    let id: Int?
    let originalTitle, releaseDate: String?
    let genres: [String]?
    let overview: String?
    let rating : Double
    let runtime: Int?
    let posterPath: String?
    let casts: [Cast]?

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case genres, overview, rating, runtime
        case posterPath = "poster_path"
        case casts
    }
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment, name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
}

