//
//  CastEntity+extension.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 11/08/2021.
//

import Foundation


extension CastEntity {
    
    static func toCastModel(entity : CastEntity) -> Cast {
        return Cast(adult: entity.adault,
                    gender: Int(entity.gender),
                    id: Int(entity.id),
                    knownForDepartment: entity.knowForDepartment,
                    name: entity.name,
                    originalName: entity.originalName,
                    popularity: entity.popularity,
                    profilePath: entity.profilePath,
                    castID: Int(entity.castID),
                    character: entity.character,
                    creditID: entity.creditID,
                    order: Int(entity.order))
    }
}
