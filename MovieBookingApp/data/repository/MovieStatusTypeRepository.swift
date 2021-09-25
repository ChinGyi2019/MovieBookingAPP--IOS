//
//  MovieStatusTypeRepository.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 13/08/2021.
//

import Foundation
import CoreData
protocol MovieStatusTypeRepository {
    
    func getStatusTypeEntity(type : MovieType)->StatusTypeEntity
    
    func save(name : String) -> StatusTypeEntity
}

class MovieStatusTypeRepositoryImpl : BaseRepository, MovieStatusTypeRepository {
    
    static let shared = MovieStatusTypeRepositoryImpl()
    private var contentTypeMap = [String:StatusTypeEntity]()
    
    private override init() {
        super.init()
        initializeData()
    }
    
    func save(name: String) -> StatusTypeEntity {
        let entity = StatusTypeEntity(context: coreData.context)
        entity.name = name
        contentTypeMap[name] =  entity
        coreData.saveContext()
        return entity
        
    }
    
    func getStatusTypeEntity(type: MovieType) -> StatusTypeEntity {
        
        if let entity = contentTypeMap[type.rawValue]{
            return entity
        }
        return save(name: type.rawValue)
        
    }
    
    private func initializeData() {
        let fetchRequest : NSFetchRequest<StatusTypeEntity> = StatusTypeEntity.fetchRequest()
        
        do {
            let dataSource = try coreData.context.fetch(fetchRequest)
            
            if dataSource.isEmpty{
                
            MovieType.allCases.forEach{
                let _ = save(name: $0.rawValue)
                }
            }else{
                //Map existing data
                dataSource.forEach{
                    if let key = $0.name{
                        contentTypeMap[key] = $0
                    }
                }
            }
            
        } catch {
            print(error)
        }
    }
    
    
}

    
