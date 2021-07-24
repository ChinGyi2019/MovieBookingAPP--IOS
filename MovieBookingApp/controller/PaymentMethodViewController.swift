//
//  PaymentMethodViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 08/06/2021.
//

import UIKit
import MMText



class PaymentMethodViewController: UIViewController {
 
    @IBOutlet weak var iCoresalView : iCarousel!
    @IBAction func didTapConfirmBtn(_ sender: Any) {
        navigateFromPaymentMethodScreenToGettingTicketScreen()
    }
   
    
    @IBAction func didTapAddNewCard(_ sender: Any) {
    
        if stackViewNewCard.isHidden{
            stackViewNewCard.isHidden = false
            addNewBtn.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
            addNewBtn.setTitle("Cancel", for: .normal)
        }else{
            addNewBtn.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
            stackViewNewCard.isHidden = true
            addNewBtn.setTitle("Add New Card", for: .normal)
          
        }
       
    }
    
    @IBOutlet weak var textFieldCardNumber: MMTextField!
    @IBOutlet weak var textFieldCVC: MMTextField!
    @IBOutlet weak var textFieldDate: MMTextField!
    
    @IBOutlet weak var textFieldCardHolder: MMTextField!
    @IBOutlet weak var collectionViewVisaCard: UICollectionView!
    @IBOutlet weak var addNewBtn: UIButton!
    @IBOutlet weak var stackViewNewCard: UIStackView!
    
    let collectionFlowLayout = UICollectionViewFlowLayout()
    //private var isShowNewCardView = false
    override class func awakeFromNib() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
       

    }
    
    fileprivate func initView(){
        navigationItem.title = "Choose Visa"
        
        setUpTextField()
        
        registerCell()
        iCoresalView.type = .rotary
    }
    
    
    
    fileprivate func registerCell(){
        iCoresalView.delegate = self
        iCoresalView.dataSource = self

    }
    
    fileprivate func setUpTextField(){
        //CardNumber
        textFieldCardNumber.titleColor = UIColor.gray
        textFieldCardNumber.titleFont = UIFont(name: "System 17", size: CGFloat(17))
        textFieldCardNumber.lineColor = UIColor.gray
        
        //CardHolder
        textFieldCardHolder.titleColor = UIColor.gray
        textFieldCardHolder.titleFont = UIFont(name: "System 17", size: CGFloat(17))
        textFieldCardHolder.lineColor = UIColor.gray
        
        //Date
        textFieldDate.titleColor = UIColor.gray
        textFieldDate.titleFont = UIFont(name: "System 17", size: CGFloat(17))
        textFieldDate.lineColor = UIColor.gray
        
        //CVC
        textFieldCVC.titleColor = UIColor.gray
        textFieldCVC.titleFont = UIFont(name: "System 17", size: CGFloat(17))
        textFieldCVC.lineColor = UIColor.gray
    }
    
    

}

extension PaymentMethodViewController : iCarouselDelegate, iCarouselDataSource{
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 3
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width / 1, height: parentSize.height)
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
    
        let visaUIView = VisaCardView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 1.2 , height: view?.frame.height ?? 230))
        

        return visaUIView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing{
            return value * 0.8
        }
        return value
    }
    
    
    
    
}
