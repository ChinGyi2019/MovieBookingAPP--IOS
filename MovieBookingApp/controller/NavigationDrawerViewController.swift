//
//  NavigationDrawerViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 15/07/2021.
//

import Foundation
import UIKit



class NavigaionDrawerViewController: UIViewController {
    
    @IBOutlet weak var logOutStackView : UIStackView!
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    private let userDefaultHelper = UserDefaultHelper.shared
    private let networkingAgent = AFNetworkingAgent.shared
    private let userModel : UserModel = UserModelImpl.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView(){
        setUpLogOutGesture()
        fetchUserProfile()
    }
    
    
    fileprivate func setUpLogOutGesture(){
        let gestureForLogOut = UITapGestureRecognizer(target: self, action: #selector(didTapLogout))
        logOutStackView.isUserInteractionEnabled = true
        logOutStackView.addGestureRecognizer(gestureForLogOut)
        
    }
    
    @objc func didTapLogout(){
    
        logout()
        
    }
    
    //MARK:- Profile
    fileprivate func fetchUserProfile(){
        userModel.getProfile { response in
            switch response{
            case .success(let data):
                self.bindProfileData(profile : data)
            case .error(let error):
                debugPrint(error)
            }
        }
    }
    
    fileprivate func bindProfileData(profile : UserData?){
        
        let backDropPath = "\(AppConstants.BASE_URL)/\( profile?.profileImage ?? "")"
        
        ivProfile.sd_setImage(with: URL(string: backDropPath))
        let name : String = profile?.name ?? ""
        
        lblUserName.text = name
        
        let email : String = profile?.email ?? ""
        lblEmail.text = email
    }
    
    fileprivate func logout(){
        networkingAgent.logOut {[weak self] response in
            
            guard let self = self else{return}
            switch response{
            case .success(let data) :
                self.showToast(message: data.message ?? "Logout Successful !", font: .systemFont(ofSize: 14.0))
                self.userDefaultHelper.deleteToken()
                self.navigateFormHomeToLoginScreen()
            case .error(let error):
                self.showToast(message: error , font: .systemFont(ofSize: 14.0))
                debugPrint(error)
            }
        }
        
        userModel.deleteUser(id: 1) {
            print("\($0)")
        }
    }
}
