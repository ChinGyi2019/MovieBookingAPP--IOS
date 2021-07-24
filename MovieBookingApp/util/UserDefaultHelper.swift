//
//  UserDefaultHelper.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 19/07/2021.
//

import Foundation

class UserDefaultHelper {
    init() {}
    static var shared =  UserDefaultHelper()
    
    private let userDefaults = UserDefaults()
    
    private static var TOKEN : String = "Token"
    private static var GOOGLE_ACCESS_TOKEN : String = "Google_Token"
    private static var FACEBOOK_ACCESS_TOKEN : String = "Facebook_Token"
    
    public func setToken(_ token : String?){
        if let token = token {
            userDefaults.setValue(token, forKey: UserDefaultHelper.TOKEN)
        }else{
            print("Token is null")
        }
        
    }
    
    public func getToken() -> String {
        
        let token =  userDefaults.string(forKey: UserDefaultHelper.TOKEN)
        if let token = token{
            return token
        }else{
            print("Token is nill")
            return ""
        }
    }
    
    func deleteToken() {
        userDefaults.removeObject(forKey: UserDefaultHelper.TOKEN)
    }
    
    //MARK:- Google
    public func setGoogleAccessToken(_ token : String?){
        if let token = token {
            userDefaults.setValue(token, forKey: UserDefaultHelper.GOOGLE_ACCESS_TOKEN)
        }else{
            print("Google Token is null")
        }
        
    }
    
    public func getGoogleAccessToken() -> String {
        
        let token =  userDefaults.string(forKey: UserDefaultHelper.GOOGLE_ACCESS_TOKEN)
        if let token = token{
            return token
        }else{
            print("Google Token is nill")
            return ""
        }
    }
    
    func deleteGoogleToken() {
        userDefaults.removeObject(forKey: UserDefaultHelper.GOOGLE_ACCESS_TOKEN)
    }
    
    //MARK:- Facebook
    public func setFacebookAccessToken(_ token : String?){
        if let token = token {
            userDefaults.setValue(token, forKey: UserDefaultHelper.FACEBOOK_ACCESS_TOKEN)
        }else{
            print("Facebook Token is null")
        }
        
    }
    
    public func getFacebookAccessToken() -> String {
        
        let token =  userDefaults.string(forKey: UserDefaultHelper.FACEBOOK_ACCESS_TOKEN)
        if let token = token{
            return token
        }else{
            print("Facebook Token is nill")
            return ""
        }
    }
    
    func deleteFacebookAccessToken() {
        userDefaults.removeObject(forKey: UserDefaultHelper.FACEBOOK_ACCESS_TOKEN)
    }
    
    
    
    
}
