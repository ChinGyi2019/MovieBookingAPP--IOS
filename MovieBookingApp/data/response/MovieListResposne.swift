//
//  MovieListResposne.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 19/07/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieListResponse = try? newJSONDecoder().decode(MovieListResponse.self, from: jsonData)

import Foundation

// MARK: - MovieListResponse
struct MovieListResponse: Codable {
    let code: Int?
    let message: String?
    let data: [MovieResult]?
}

// MARK: - Datum
struct MovieResult: Codable {
    let id: Int?
    let originalTitle, releaseDate: String?
    let genres: [String]?
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case genres
        case posterPath = "poster_path"
    }
}
