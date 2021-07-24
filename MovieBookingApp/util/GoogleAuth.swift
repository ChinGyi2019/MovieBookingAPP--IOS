//
//  GoogleAuth.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 21/07/2021.
//

import Foundation
import GoogleSignIn
import UIKit


public class GoogleAuth : NSObject {

private var onGoogleAuthFailed:((String)->Void)?
private var onGoogleAuthSuccess:((GoogleAuthProfileResponse)->Void)?

public override init() {
  super.init()
}

    public func start(view : UIViewController?, success: @escaping ((GoogleAuthProfileResponse)->Void), failure: @escaping ((String) -> Void) ) {
        let signInConfig = GIDConfiguration.init(clientID: AppConstants.googleClientID)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: view!){
            user, error in
            guard error == nil else {return}
            guard let user = user else { return }
            
            

           //Success
            success(user.ToGoogleAuthProfileResponse())
            
            //Error
            if let error = error {
            if (error as NSError).code == GIDSignInError.hasNoAuthInKeychain.rawValue {
                failure("The user has not signed in before or they have since signed out.")
               
            }else{
                failure("\(error.localizedDescription)")
            }
            }
           
         
           
        }
    }
    

    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInError.hasNoAuthInKeychain.rawValue {

                onGoogleAuthFailed?("The user has not signed in before or they have since signed out.")
            }else{
                onGoogleAuthFailed?("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        let userId = user.userID ?? ""
        // For client-side use only!
        let token = user.authentication.idToken ?? ""
        let fullName = user.profile?.name ?? ""
        let givenName = user.profile?.givenName ?? ""
        let familyName = user.profile?.familyName ?? ""
        let email = user.profile?.email ?? ""
        
        let userData = GoogleAuthProfileResponse(id: userId, token: token, fullname: fullName, giveName: givenName, familyName: familyName, email: email)
        
            onGoogleAuthSuccess?(userData)
    }

    
}
public struct GoogleAuthProfileResponse {
    public let id, token, fullname, giveName, familyName, email : String
    
    func  toUserModel() -> User {
        return User(name: fullname, email: email, phone: "", password: "", googleAccessToken: token, facebookAccessToken: "")
    }
    
}

extension GIDGoogleUser{
    
    func ToGoogleAuthProfileResponse() -> GoogleAuthProfileResponse {
    let userId = self.userID ?? ""
    // For client-side use only!

    let token = self.authentication.accessToken // i chnage  uthentication.idToken to authentication.accessToken
    let fullName = self.profile?.name ?? ""
    let givenName = self.profile?.givenName ?? ""
    let familyName = self.profile?.familyName ?? ""
    let email = self.profile?.email ?? ""
    
    return GoogleAuthProfileResponse(id: userId, token: token, fullname: fullName, giveName: givenName, familyName: familyName, email: email)
        
    }
}

