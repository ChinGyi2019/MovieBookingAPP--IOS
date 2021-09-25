//
//  MovieRepository.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 11/08/2021.
//

import Foundation
import CoreData
import RxSwift
import RxCoreData


protocol MovieRepository {
    
    
    func saveDetail(data : MovieDetails?)
    
    func saveList(status : MovieType,data : [MovieResult])
    
    func getDetail(id : Int, completion : @escaping (MovieDetails?) -> Void)
    
    func getMovies(page: Int, take : Int, type : MovieType, completion : @escaping ([MovieResult]) -> Void)
    //Observables
    func getDetail(id : Int) -> Observable<MovieDetails>
    
    func getMovies(page: Int, take : Int, type : MovieType) -> Observable<[MovieResult]>
}

class MovieRepositoryImpl : BaseRepository, MovieRepository {
    
    private let fetchLimit = 15
    
    func delete(type : MovieType) {
        do {
            
            let fetchRequest : NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(
                format: "SUBQUERY(" +
                    "statusType, " +
                    "$type, " +
                    "$type.name ==[cd] \"\(type.rawValue)\"" +
                    ").@count >0"
            )
            
            let results = try coreData.context.fetch(fetchRequest)
            
            for (i, value) in results.enumerated() {
                if (i < 3) {
                    coreData.context.delete(value)
                }
                
            }
            
            coreData.saveContext()
            
            
        } catch {
            print("\(#function) \(error.localizedDescription)")
        }
    }
    
    func getDetail(id: Int) -> Observable<MovieDetails> {
        
        
//        coreData.context.rx.entities(MovieEntity.self,
//                                                 sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)])
        
        let fetchRequest : NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "%K = %@", "id", "\(id)")
        
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "rating", ascending: false),
            NSSortDescriptor(key: "originalTitle", ascending: true)
        ]
        
        return CDObservable(fetchRequest: fetchRequest, context: coreData.context)
            .flatMap {  items -> Observable<MovieDetails> in
                
                if let firstItem = items.first{
                    return .just(MovieEntity.toMovieDetails(firstItem))
                }else{
                    print("else entered")
                
                    return .just(MovieDetails.empty())
                }
                
                
            }
    }
    
    func getMovies(page: Int, take: Int, type: MovieType) -> Observable<[MovieResult]> {
        
        let fetchRequest : NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "SUBQUERY(" +
                "statusType, " +
                "$type, " +
                "$type.name ==[cd] \"\(type.rawValue)\"" +
                ").@count >0"
        )
        
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "rating", ascending: false)
        ]
        var mPage = 1
        if take % fetchLimit == 0{
            mPage = take / fetchLimit
        }else {
            mPage += 1
        }
        
        fetchRequest.fetchLimit = fetchLimit
        fetchRequest.fetchOffset = (mPage * fetchLimit) - fetchLimit
        
        
        return CDObservable(fetchRequest: fetchRequest, context: coreData.context)
            .flatMap { items -> Observable<[MovieResult]> in
                .just(items.map({ MovieEntity.toMovieResult($0) }))
            }
        
    }
    
    
    private override init() {}
    
    static let shared = MovieRepositoryImpl()
    private let statusTypeRepo = MovieStatusTypeRepositoryImpl.shared
    
    func getDetail(id: Int, completion: @escaping (MovieDetails?) -> Void) {
        //coreData.context.perform {
        let fetchRequest : NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        
        fetchRequest.predicate = NSPredicate(format: "%K = %@", "id", "\(id)")
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "rating", ascending: false)
        ]
        
        if let items = try? coreData.context.fetch(fetchRequest),
           let item = items.first{
            
            completion(MovieEntity.toMovieDetails(item))
            
        } else {
            print("\(#function): Cannot found movie -> \(id)" )
            completion(nil)
        }
        
        
        
    }
    
    func saveDetail(data: MovieDetails?) {
        
        //Background Thread
        //        coreData.context.perform {
        //  coreData.context.perform {
        //coreData.context ==> main Thread
        let _ = data?.toMovieEntity(context: self.coreData.context)
        
        self.coreData.saveContext()
        // }
    }
    
    func saveList(status: MovieType, data: [MovieResult]){
        
        data.forEach {
            $0.toMovieEntity(type: status, context: coreData.context,statusTypeRepo: statusTypeRepo)
        }
        coreData.saveContext()
        
    }
    
    func getMovies(page: Int, take : Int,type: MovieType, completion: @escaping ([MovieResult]) -> Void) {
        
        let fetchRequest : NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "SUBQUERY(" +
                "statusType, " +
                "$type, " +
                "$type.name ==[cd] \"\(type.rawValue)\"" +
                ").@count >0"
        )
        
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "rating", ascending: false)
        ]
        
        fetchRequest.fetchLimit = take
        fetchRequest.fetchOffset = (page * take) - take
        
        do {
            
            let results = try coreData.context.fetch(fetchRequest)
            let sortedData = Array(results.sorted(by: { (first, second) in
                
                let datFormatter = DateFormatter()
                datFormatter.dateFormat = "yyyy-MM-dd"
                
                let firstDate = datFormatter.date(from: first.releaseDate ?? "") ?? Date()
                
                let secondDate = datFormatter.date(from: second.releaseDate ?? "") ?? Date()
                
                return firstDate.compare(secondDate) == .orderedDescending
                
            })).map { MovieEntity.toMovieResult($0)}
            
            completion(sortedData)
            
        } catch {
            
            completion([MovieResult]())
            print("\(#function):\(error)")
            
        }
        
    }
    
    
}


