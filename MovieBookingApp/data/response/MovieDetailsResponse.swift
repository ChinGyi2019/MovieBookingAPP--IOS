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
import CoreData

// MARK: - MovieDetailsResponse
struct MovieDetailsResponse: Codable {
    let code: Int?
    let message: String?
    let data: MovieDetails?
    
    enum CodingKeys: String, CodingKey {
        case code, message, data
    }
    
    static func empty() -> MovieDetailsResponse{
        return MovieDetailsResponse(code: nil, message: nil, data: nil)
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
    static func empty() -> MovieDetails{
        return MovieDetails(id: nil,
                            originalTitle: nil,
                            releaseDate: nil,
                            genres: nil,
                            overview: nil,
                            rating: 0.0,
                            runtime: nil,
                            posterPath: nil,
                            casts: nil)
    }
    @discardableResult
    func toMovieEntity(context : NSManagedObjectContext) -> MovieEntity{
        
        let entity = MovieEntity(context: context)
            
        entity.id = Int64(id ?? 0)
        entity.originalTitle = originalTitle
        entity.releaseDate = releaseDate
        entity.genres = genres?.map{String($0)}.joined(separator: ",")
        entity.posterPath = posterPath
        entity.rating = rating
        entity.overview = overview
        entity.runTime = Int64(runtime ?? 0)
        
        casts?.forEach{
            entity.addToCasts($0.toCastEntity(context: context))
        }
        
        
        
        return entity
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
    
    func  toCastEntity(context : NSManagedObjectContext) -> CastEntity {
        let entity = CastEntity(context: context)
        entity.id = Int32(id ?? 0)
        entity.adault = adult ?? false
        entity.gender = Int32(gender ?? 0)
        entity.knowForDepartment = knownForDepartment
        entity.name = name
        entity.originalName = originalName
        entity.popularity = popularity ?? 0.0
        entity.profilePath = profilePath
        entity.castID = Int32(castID ?? 0)
        entity.character = character
        entity.creditID = creditID
        entity.order = Int64(order ?? 0)
        
        return entity
    }
}

