//
//  AuthenticationViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 07/06/2021.
//

import UIKit
import MMText
import Foundation

class AuthenticationViewController : UIViewController, LoginDelegate, SignDelegate, GoogleFacebookDelegate{
   

    
    //MARK:- IBoutlet
    @IBOutlet weak var collectionTabUIView: UICollectionView!
    @IBOutlet weak var collectionContainerView: UICollectionView!
    
    @IBOutlet weak var collectionTabUIViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionContainerViewHeight: NSLayoutConstraint!
    
    
    //MARK:- AuthDelegate
    func didTapRegisterBtn(user : User) {
        print("Taped Register")
        
        self.user = user
        didTapUITabView(tabName: loginAndSignConstant[0].name)
        
        
    }
    
    func signError(message: String) {
        showAlert(title: "Sign In Error!", message: message)
    }
    
    
    func didTabConfirmBtn() {
        print("Taped Confird")
        navigateFormAuthScreenToHomeScreen()
    }
    
    func loginShowError(message: String) {
        showAlert(title: "Login Error!", message: message)
     
    }
    //Facebook, Google
    func didTapGoogleBtn() {
        
        googleAuth.start(view: self) { data in
            self.user = data.toUserModel()
            //Save GoogleAccessToken
            self.userDefault.setGoogleAccessToken(data.token)
            self.collectionContainerView.reloadData()
        } failure: { error in
            print(error)
        }

    }
    
    func didTapFacebookBtn() {
        print("")
    }
    
    //MARK:- Properties
    
    private var googleAuth = GoogleAuth()
    private var userDefault = UserDefaultHelper()
    var user : User? = nil
    var previousIndex : Int?
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
