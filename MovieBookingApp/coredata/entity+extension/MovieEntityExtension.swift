//
//  MovieEntityExtension.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 11/08/2021.
//

import Foundation
import CoreData
import RxCoreData
import RxDataSources


extension MovieEntity{
    
    static func toMovieResult(_ entity : MovieEntity)->MovieResult{
        return MovieResult(id: Int(entity.id),
                           originalTitle: entity.originalTitle,
                           releaseDate: entity.releaseDate,
                           genres: entity.genres?.components(separatedBy: ","),
                           posterPath: entity.posterPath)
    }
    
    static func toMovieDetails(_ entity : MovieEntity) -> MovieDetails{
        return MovieDetails(id: Int(entity.id),
                            originalTitle: entity.originalTitle,
                            releaseDate: entity.releaseDate,
                            genres: entity.genres?.components(separatedBy: ","),
                            overview: entity.overview,
                            rating: entity.rating,
                            runtime: Int(entity.runTime),
                            posterPath: entity.posterPath,
                            casts: getCastArray(set: entity.casts))
    }
    
    static func getCastArray(set : NSSet?)-> [Cast]{
        if let set = set as? Set<CastEntity>{
           return set.map{
                CastEntity.toCastModel(entity: $0)
            }
        }else{
          return [Cast]()
        }
    }
}




//extension MovieEntity : Persistable{
//    public static var entityName: String {
//        return "MovieEntity"
//    }
//
//    public static var primaryAttributeName: String {
//        return "id"
//    }
//
//    public var identity: String {
//        return "\(id)"
//    }
//
//    public func update(_ entity: MovieEntity) {
//
//    }
//
//
//    public typealias T = MovieEntity
//
//
//}

//func == (lhs: MovieEntity, rhs: MovieEntity) -> Bool {
//    return lhs.id == rhs.id
//}
//
//
//
//extension MovieEntity : IdentifiableType {
//}



//extension MovieEntity : Persistable {
//    
//    public func update(_ entity: MovieEntity) {
//        
//    }
//    
////    public init(entity: MovieEntity) {
////
////    }
//    
//    public func predicate() -> NSPredicate {
//        return NSPredicate(format: "%K = %@", Self.primaryAttributeName, self.identity)
//    }
//
//    public static var entityName: String {
//        return "MovieEntity"
//    }
//
//    public static var primaryAttributeName: String {
//        return "id"
//    }
//
//    public var identity: String {
//        return "\(id)"
//    }
//
//
//    public typealias T = MovieEntity
//
//    //public typealias T = NSManagedObject
//
//
//}
    
