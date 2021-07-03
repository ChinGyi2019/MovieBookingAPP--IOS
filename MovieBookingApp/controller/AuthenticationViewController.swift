//
//  AuthenticationViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 07/06/2021.
//

import UIKit
import MMText
import Foundation

class AuthenticationViewController : UIViewController, AuthDelegate{
    func didTabConfirmBtn() {
        navigateFormAuthScreenToHomeScreen()
    }
    
    
   
   
    var previousIndex : Int?
    
   
    var loginAndSignConstant : [TabViewItem] =
        [TabViewItem(name: "Login", isSelected: true),TabViewItem(name: "Sign", isSelected: false)]
   
    @IBOutlet weak var collectionTabUIView: UICollectionView!
    @IBOutlet weak var collectionContainerView: UICollectionView!
    
    @IBOutlet weak var collectionTabUIViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionContainerViewHeight: NSLayoutConstraint!
    
    @IBAction func didTapConfirmBtn(_ sender: Any) {
        //navigateFormAuthScreenToHomeScreen()
       
    }
//   
    
    @IBOutlet var stackViewFacebookBtn: UIStackView!
    @IBOutlet var stackViewGoogleBtn: UIStackView!
    //@IBInspectable public var titleColor: UIColor
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRoundCorners()
        
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
        
        
        collectionTabUIViewHeight.constant = 60
      //  collectionContainerViewHeight.constant = 800
       
       
    }
        
    fileprivate func registerForCell(){
        //DataSource
        
        
        //Registger
        collectionTabUIView.registerForCell(identifier: TabLoginCollectionViewCell.identifier)
        //Register for LoginTabCollectionViewCell && SignInTabCollectionViewCell
        collectionContainerView.registerForCell(identifier: LoginTabCollectionViewCell.identifier)
        collectionContainerView.registerForCell(identifier: SignInTabCollectionViewCell.identifier)
    }
   
    fileprivate func setUpRoundCorners(){
       
        
        //Round and Add Borders
        stackViewFacebookBtn.addBorderLine(radius: 8, width: 1, color: UIColor.gray.cgColor)
        stackViewGoogleBtn.addBorderLine(radius: 8, width: 1, color: UIColor.gray.cgColor)
     
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.collectionContainerViewHeight.constant = collectionContainerView.collectionViewLayout.collectionViewContentSize.height
        view.layoutIfNeeded()
    }

}
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
            
            var selectedSection = 0
            for (index, item) in self.loginAndSignConstant.enumerated(){
                
                self.collectionContainerView.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.right, animated: true)
                if name == item.name{
                    item.isSelected = true
                    selectedSection = index
                 
                }else{
                    
                    item.isSelected = false
                }
               print(selectedSection)
                self.collectionContainerView.scrollToItem(at: IndexPath(row: 0, section : selectedSection), at: .right, animated: true)
                self.collectionTabUIView.reloadData()
            }
            

        }
            return cell
            
        }else{
            
            switch indexPath.section {
            
            
            case 0:
                let cell  = collectionView.dequeueCell(identifier: LoginTabCollectionViewCell.identifier, indexPath: indexPath) as! LoginTabCollectionViewCell
                cell.delegate = self
                return cell
            case 1:
                let cell  = collectionView.dequeueCell(identifier: SignInTabCollectionViewCell.identifier, indexPath: indexPath) as! SignInTabCollectionViewCell
                cell.delegate = self
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
