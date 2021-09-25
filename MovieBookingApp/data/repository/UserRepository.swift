//
//  UserRepository.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 12/08/2021.
//

import Foundation
import CoreData

protocol UserRepository {
    
    func getProfile(completion: @escaping (UserData?) -> Void)
    
    func save(data : UserData?)
    
    func deleteUser(id : Int, completion : @escaping(String)->Void)
}

class UserRepositoryImpl : BaseRepository, UserRepository{
    
    func deleteUser(id: Int, completion: @escaping (String) -> Void) {
        let userId : Int  = 1
        let fetchRequest : NSFetchRequest<ProfileEntity> = ProfileEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K = %@", "id","\(userId)")
        
        
        if let users = try? coreData.context.fetch(fetchRequest),
           let user = users.first{
            coreData.context.delete(user)
            completion("Success Delete user \(id)")
        }else{
            completion("error deleting user ->\(id)")
        }
        
        coreData.saveContext()
                
    }
    
   
    static let shared = UserRepositoryImpl()
    private override init() { }
    
    func save(data: UserData?) {
        
        let _ = data?.toProfileEntity(coreData.context)
        
        coreData.saveContext()
    }
    
    func getProfile(completion: @escaping (UserData?) -> Void) {
        
        let userId : Int  = 1
        let fetchRequest : NSFetchRequest<ProfileEntity> = ProfileEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K = %@", "id","\(userId)")
//
        
        
        if let users = try? coreData.context.fetch(fetchRequest),
           let user = users.first{
            completion(ProfileEntity.toUserData(user))
        }else{
            completion(nil)
        }
                                
        
    }
    

}
