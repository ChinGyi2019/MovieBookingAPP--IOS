//
//  AuthenticationViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 07/06/2021.
//

import UIKit
import MMText
import Foundation

class AuthenticationViewController : UIViewController, LoginDelegate, SignDelegate, GoogleFacebookRegisterDelegate, GoogleFacebookLoginDelegate{

    //MARK:- IBoutlet
    @IBOutlet weak var collectionTabUIView: UICollectionView!
    @IBOutlet weak var collectionContainerView: UICollectionView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var collectionTabUIViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionContainerViewHeight: NSLayoutConstraint!
    
    
    //MARK:- AuthDelegate
    
    //Mark:- Handle Signin Error
    func didTapRegisterBtn(user : User) {
        print("Taped Register")
        
        self.user = user
        didTapUITabView(tabName: loginAndSignConstant[0].name)
        
        
    }
    
    func signError(message: String) {
        showAlert(title: "Sign In Error!", message: message)
    }
    
    //Register with Google
    func didTapRegisterGoogleBtn() {
        
        googleAuth.start(view: self) { data in
            self.user = data.toUserModel()
            self.collectionContainerView.reloadData()
        } failure: { error in
            print(error)
        }

    }
    //Register With Facebook
    func didTapRegisterFacebookBtn() {
        facebookAuth.start(vc: self) { data in

            self.user = data.toUserModel()
            self.collectionContainerView.reloadData()
        } failure: { error in
            print(error)
        }
    }
    
    //Login With Google
    func didTapLoginGoogleBtn() {
        
        googleAuth.start(view: self) { data in
        
            self.loginWithGoogle(googleToken: String(data.id))
        } failure: { error in
            self.showAlert(title: "Login Failed !", message: error)
        }
    }
    //Login With Facebook
    func didTapLoginFacebookBtn() {
        facebookAuth.start(vc: self) { data in
            self.loginWithFacebook(facebookToken: data.id)
        } failure: { error in
            print(error)
        }

    }
    
    //Handle Error Login with Email
    func didTabConfirmBtn() {
        navigateFormAuthScreenToHomeScreen()
    }
    
    func loginShowError(message: String) {
        showAlert(title: "Login Error!", message: message)
     
    }
    
    
   
    
    //MARK:- Properties
    private var googleAuth = GoogleAuth()
    private var facebookAuth = FacebookAuth()
    private var userDefault = UserDefaultHelper()
    var user : User? = nil
    var previousIndex : Int?
    
    private var netwrokingAgent = AFNetworkingAgent.shared
    var loginAndSignConstant : [TabViewItem] =
        [TabViewItem(name: "Login", isSelected: true),TabViewItem(name: "Sign", isSelected: false)]
   
    
    //MARK:- View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.collectionContainerViewHeight.constant = collectionContainerView.collectionViewLayout.collectionViewContentSize.height
        view.layoutIfNeeded()
    }
    
    //MARK:- UI SetUp
    fileprivate func initView(){
        indicatorView.isHidden = true
        indicatorView.hidesWhenStopped = true
        //Register And SetupDataAndDelegate
        setUpDelegateAndDataSource()
        registerForCell()
        
    }
    fileprivate func setUpDelegateAndDataSource(){
        collectionTabUIView.delegate = self
        collectionTabUIView.dataSource = self
        collectionTabUIView.allowsMultipleSelection = true
        
        collectionContainerView.delegate = self
        collectionContainerView.dataSource = self
        collectionContainerView.allowsMultipleSelection = true
        
        collectionContainerView.isScrollEnabled = false
        collectionTabUIViewHeight.constant = 60
      
        
    }
    
    fileprivate func registerForCell(){
    
        //Registger
        collectionTabUIView.registerForCell(identifier: TabLoginCollectionViewCell.identifier)
        //Register for LoginTabCollectionViewCell && SignInTabCollectionViewCell
        collectionContainerView.registerForCell(identifier: LoginTabCollectionViewCell.identifier)
        collectionContainerView.registerForCell(identifier: SignInTabCollectionViewCell.identifier)
    }
    
    fileprivate func didTapUITabView(tabName : String){
        var selectedSection = 0
        for (index, item) in self.loginAndSignConstant.enumerated(){
            
            if tabName == item.name{
                item.isSelected = true
                selectedSection = index
                
            }else{
                item.isSelected = false
            }
            print(selectedSection)
            self.collectionContainerView.scrollToItem(at: IndexPath(row: 0, section : selectedSection), at: .right, animated: true)
            self.collectionTabUIView.reloadData()
            self.collectionContainerView.reloadData()
        }
    }
    
    fileprivate func loginWithGoogle(googleToken : String){
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        netwrokingAgent.loginWithGoogle(googleToken) { result in
            self.doLoginProcess(result)
        }
    }
    
    fileprivate func loginWithFacebook(facebookToken : String){
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        netwrokingAgent.loginWithFacebook(facebookToken) { result in
            self.doLoginProcess(result)
        }
    }
    
    
   
    
    fileprivate func doLoginProcess(_ result : NetworkResult<RegisterResponse>){
        
        switch result{
        case .success(let data):
            print(data.message ?? "login success message nil")
            //Code is 400
            if let code = data.code {
                if code >= 400{
                    showAlert(title: "Login Failed !", message: data.message ?? "")
                    indicatorView.isHidden = true
                    indicatorView.stopAnimating()
                return
                }
            }
            //Set Token To UserDefaults
            self.userDefault.setToken(data.token)
            indicatorView.isHidden = true
            indicatorView.stopAnimating()
            self.navigateFormAuthScreenToHomeScreen()
        
        case .error(let error):
            print("\(error)")
            showAlert(title: "Login Failed !", message: error)
            indicatorView.isHidden = true
            indicatorView.stopAnimating()
        }
        
    }
    
}

//MARK:- View Extension
extension AuthenticationViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionContainerView{
            return 1
        }
        return loginAndSignConstant.count
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == collectionTabUIView{
            return 1
        }else{
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionTabUIView {
            let cell  = collectionView.dequeueCell(identifier: TabLoginCollectionViewCell.identifier, indexPath: indexPath) as! TabLoginCollectionViewCell
            
            if indexPath.row == 0{
                cell.isSelected = true
            }
            
            cell.data = loginAndSignConstant[indexPath.row]
            cell.onTapItem = { name in
                
             self.didTapUITabView(tabName: name)
                
            }
            return cell
            
        }else{
            
            switch indexPath.section {
                
            case 0:
                let cell  = collectionView.dequeueCell(identifier: LoginTabCollectionViewCell.identifier, indexPath: indexPath) as! LoginTabCollectionViewCell
                cell.delegate = self
                cell.googleFacebookLoginDelegate = self
                cell.user  = user
                return cell
            case 1:
                let cell  = collectionView.dequeueCell(identifier: SignInTabCollectionViewCell.identifier, indexPath: indexPath) as! SignInTabCollectionViewCell
                cell.googleFacebookDelegate = self
                cell.delegate = self
                cell.user = user
                
                return cell
                
            default:
                return UICollectionViewCell()
            }
            
        }
        
    }
    
}

extension AuthenticationViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionTabUIView{
            let  width = collectionView.bounds.width/2
            let height : CGFloat = 60
            
            return CGSize(width: width, height: height)
        }else{
            let  width = collectionView.frame.width
            let height : CGFloat = collectionView.bounds.height
            
            return CGSize(width: width, height: height)
        }
    }
    
    
}
