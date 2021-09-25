//
//  UserRepository.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 12/08/2021.
//

import Foundation


protocol UserModel {
    func getProfile(completion: @escaping (NetworkResult<UserData?>) -> Void)
    
    func deleteUser(id : Int, completion : @escaping(String)->Void)
}

class UserModelImpl : BaseModel, UserModel{
    func deleteUser(id: Int, completion: @escaping (String) -> Void) {
        self.userRepository.deleteUser(id: id, completion: completion)
    }
    
    private let userRepository = UserRepositoryImpl.shared
    
    func getProfile(completion: @escaping (NetworkResult<UserData?>) -> Void) {
        
        self.userRepository.getProfile { userData in
            if let data = userData{
                completion(.success(data))
            }else{
                completion(.error("There is no such a user"))
            }
        }
        
        networkingAgent.getProfile { result in
            switch result {
            case . success(let data):
                self.userRepository.save(data: data.data)
                
                
            case .error(let error):
                print("\(#function):\(error)")
            }
            
            self.userRepository.getProfile { userData in
                if let data = userData{
                    completion(.success(data))
                }else{
                    completion(.error("There is no such a user"))
                }
            }
            
        }
    
    }
    
    
    
    static let shared = UserModelImpl()
    private override init() {}
    
}
