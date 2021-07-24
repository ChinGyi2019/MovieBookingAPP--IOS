//
//  LoginTabCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 25/06/2021.
//

import UIKit
import MMText


class LoginTabCollectionViewCell: UICollectionViewCell {
    @IBOutlet var textFieldEmail: MMTextField!
     @IBOutlet var textFieldPassword: MMTextField!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
   
    @IBOutlet var stackViewFacebookBtn: UIStackView!
    @IBOutlet var stackViewGoogleBtn: UIStackView!
    @IBAction func didTapConfirmButton(_ sender: Any) {
       didTapLoginBtn()
    }
    
    var user : User? {
        didSet{
            if let user = user{
                textFieldEmail.text = user.email
                textFieldPassword.text = user.password
            }
        }
    }
    var delegate : LoginDelegate? = nil
    
    private var netwrokingAgent = AFNetworkingAgent.shared
    private var userDefault = UserDefaultHelper.shared
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
       initView()
       
    }
    
    fileprivate func initView(){
        indicatorView.isHidden = true
        indicatorView.hidesWhenStopped = true
        mmTextView()
        setUpRoundCorners()
        setUpGestureForGoogleAndFacebook()
        
    }
    
    fileprivate func mmTextView(){
        //For Email TextField
        textFieldEmail.titleFont = UIFont (name: "System 14", size: 14)
        textFieldEmail.titleColor = UIColor(named: "color_seat_taken") ?? UIColor.gray

       // For Password TextField
        textFieldPassword.titleFont = UIFont (name: "System 14", size: 14)
        textFieldPassword.titleColor = UIColor(named: "color_seat_taken") ?? UIColor.gray
    }
    
    fileprivate func setUpRoundCorners(){
       
        //Round and Add Borders
        stackViewFacebookBtn.addBorderLine(radius: 8, width: 1, color: UIColor.gray.cgColor)
        stackViewGoogleBtn.addBorderLine(radius: 8, width: 1, color: UIColor.gray.cgColor)
     
    }
    
    private func setUpGestureForGoogleAndFacebook(){
        let gestureForGoogle = UITapGestureRecognizer(target: self, action: #selector(didTapGoogleLoginBtn))
        stackViewGoogleBtn.isUserInteractionEnabled = true
        stackViewGoogleBtn.addGestureRecognizer(gestureForGoogle)
    }
    
    @objc func didTapGoogleLoginBtn(){
        let googleToken = userDefault.getGoogleAccessToken()
        if  googleToken != "" && !googleToken.isEmpty{
            loginWithGoogle(googleToken: googleToken)
        }else{
            delegate?.loginShowError(message: "You dont have Sign in yet!")
        }
    }
    
    fileprivate func didTapLoginBtn(){
        checkTextFieldsisEmpty{
            login()
        }
        
    }
    
    fileprivate func checkTextFieldsisEmpty(doLogin : ()->Void){
        let red = UIColor(red: 100.0, green: 130.0, blue: 230.0, alpha: 1.0)
         if textFieldEmail.text?.isEmpty  == true{
            textFieldEmail.isError(baseColor: red.cgColor, numberOfShakes: 1.0, revert: true)
            textFieldEmail.placeholder = "Please Enter Email"
        }else if textFieldPassword.text?.isEmpty == true{
            textFieldPassword.isError(baseColor: red.cgColor, numberOfShakes: 1.0, revert: true)
            textFieldPassword.placeholder = "Please Enter Password"
        }else{
            indicatorView.isHidden = false
            indicatorView.startAnimating()
    
            doLogin()
            
            
        }
    }
    
    fileprivate func clearTextFieldText(){
        textFieldEmail.text = ""
        textFieldPassword.text = ""
        self.indicatorView.stopAnimating()
    }
    
    fileprivate func login(){
       
        let email = textFieldEmail.text
        let password = textFieldPassword.text
        let user =  User(name: "", email: email, phone: "", password: password, googleAccessToken: "", facebookAccessToken: "")
        netwrokingAgent.loginWithEmail(user: user) { [weak self] result in
            guard let self = self else {return}
            self.loginProcess(result)
            
        }
    }
    fileprivate func loginWithGoogle(googleToken : String){
        netwrokingAgent.loginWithGoogle(googleToken) { result in
            self.loginProcess(result)
        }
    }
    
    fileprivate func loginProcess(_ result : NetworkResult<RegisterResponse>){
        
        switch result{
        case .success(let data):
            print(data.message ?? "login success message nil")
            if let code = data.code {
                if code >= 400{
                self.delegate?.loginShowError(message: data.message ?? "Login Something went wrong")
                self.indicatorView.stopAnimating()
                return
                }
            }
            //Set Token To UserDefaults
            self.userDefault.setToken(data.token)
            self.delegate?.didTabConfirmBtn()
            //Clear User data
            self.clearTextFieldText()
            
        case .error(let error):
            print("\(error)")
            self.delegate?.loginShowError(message: error)
            self.indicatorView.stopAnimating()
        }
        
    
        
    }

}
