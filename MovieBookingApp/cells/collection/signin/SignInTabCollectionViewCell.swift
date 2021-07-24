//
//  SignInTabCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 25/06/2021.
//

import UIKit
import MMText

class SignInTabCollectionViewCell: UICollectionViewCell {
    @IBOutlet var textUserName: MMTextField!
    @IBOutlet var textFieldEmail: MMTextField!
    @IBOutlet var textFieldPhone: MMTextField!
     @IBOutlet var textFieldPassword: MMTextField!
    @IBOutlet weak var indicatorView : UIActivityIndicatorView!
    @IBOutlet var stackViewFacebookBtn: UIStackView!
    @IBOutlet var stackViewGoogleBtn: UIStackView!
    
    var delegate : SignDelegate? = nil
    var googleFacebookDelegate : GoogleFacebookDelegate? = nil
    
    private var networkAgent = AFNetworkingAgent.shared
    private var userDefaultHelper = UserDefaultHelper.shared
    
    var user : User?{
        didSet{
            if let user = user{
                textUserName.text = user.name
                textFieldEmail.text = user.email
                textFieldPhone.text = user.phone
                textFieldPassword.text = user.password
                
            }
        }
    }
    
    @IBAction func didTapConfirmButton(_ sender: Any) {
        didTapConfirmedBtn()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    private func initView(){
        indicatorView.isHidden = true
        indicatorView.hidesWhenStopped = true
        
        mmTextView()
        setUpRoundCorners()
        gestureInit()
    }
    
    
    
    fileprivate func mmTextView(){
        
        //For textUserName TextField
        textUserName.titleFont = UIFont (name: "System 14", size: 14)
        textUserName.titleColor = UIColor(named: "color_seat_taken") ?? UIColor.gray
        textUserName.placeholder = "Enter Your Name"
        //For Email TextField
        textFieldEmail.titleFont = UIFont (name: "System 14", size: 14)
        textFieldEmail.titleColor = UIColor(named: "color_seat_taken") ?? UIColor.gray
        textFieldEmail.placeholder = "user@gmail.com"

        //For Password TextField
        textFieldPassword.titleFont = UIFont (name: "System 14", size: 14)
        textFieldPassword.titleColor = UIColor(named: "color_seat_taken") ?? UIColor.gray
        
        
        //For Phone TextField
        textFieldPhone.titleFont = UIFont (name: "System 14", size: 14)
        textFieldPhone.titleColor = UIColor(named: "color_seat_taken") ?? UIColor.gray
        textFieldPhone.placeholder = "959 ***** *****"
    }
    
    fileprivate func setUpRoundCorners(){
       
        //Round and Add Borders
        stackViewFacebookBtn.addBorderLine(radius: 8, width: 1, color: UIColor.gray.cgColor)
        stackViewGoogleBtn.addBorderLine(radius: 8, width: 1, color: UIColor.gray.cgColor)
     
    }
    
    fileprivate func didTapConfirmedBtn(){
        checkTextFieldsisEmpty()
    }
    
    fileprivate func checkTextFieldsisEmpty(){
        let red = UIColor(red: 100.0, green: 130.0, blue: 230.0, alpha: 1.0)
        if textUserName.text?.isEmpty == true{
            textUserName.isError(baseColor: red.cgColor, numberOfShakes: 1.0, revert: true)
            textUserName.placeholder = "Please Enter Name"
        }else if textFieldEmail.text?.isEmpty  == true{
            textFieldEmail.isError(baseColor: red.cgColor, numberOfShakes: 1.0, revert: true)
            textFieldEmail.placeholder = "Please Enter Email"
        }else if textFieldPhone.text?.isEmpty  == true{
            textFieldPhone.isError(baseColor: red.cgColor, numberOfShakes: 1.0, revert: true)
            textFieldPhone.placeholder = "Please Enter Phone"
        }else if textFieldPassword.text?.isEmpty == true{
            textFieldPassword.isError(baseColor: red.cgColor, numberOfShakes: 1.0, revert: true)
            textFieldPassword.placeholder = "Please Enter Password"
        }else{
            indicatorView.isHidden = false
            indicatorView.startAnimating()
            register()
            
        }
    }
    
    private func clearTextFieldText(){
        textUserName.text = ""
        textFieldEmail.text = ""
        textFieldPassword.text = ""
        textFieldPhone.text = ""
        
    }
    
    private func gestureInit(){
        let gestureForGoogleBtn = UITapGestureRecognizer(target: self, action: #selector(onTapGoogleBtn))
        stackViewGoogleBtn.isUserInteractionEnabled = true
        stackViewGoogleBtn.addGestureRecognizer(gestureForGoogleBtn)
    }
    @objc func onTapGoogleBtn(){
        googleFacebookDelegate?.didTapGoogleBtn()

    }
    
    fileprivate func register(){
        let name = textUserName.text
        let email = textFieldEmail.text
        let phone = textFieldPhone.text
        let password = textFieldPassword.text
        let user =  User(name: name, email: email, phone: phone, password: password, googleAccessToken: user?.googleAccessToken ?? "", facebookAccessToken: "")
        networkAgent.register(user: user) { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let data):
                //Set Token To UserDefaults
                if let code = data.code{
                    if code >= 400{
                        self.delegate?.signError(message: data.message ?? "singin failed")
                      return
                    }
                }
                self.userDefaultHelper.setToken(data.token)
                self.delegate?.didTapRegisterBtn(user: user)
                print(data.message ?? "register success message nil")
                self.indicatorView.stopAnimating()
                //Clear User data
                self.clearTextFieldText()
                
               
                
            case .error(let error):
                print("\(error)")
                self.delegate?.signError(message: error)
                self.indicatorView.stopAnimating()
            }
            
        }
    }

}
