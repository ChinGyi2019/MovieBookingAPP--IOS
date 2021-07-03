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
    @IBAction func ditTapBackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var textFieldCardNumber: MMTextField!
    @IBOutlet weak var textFieldCVC: MMTextField!
    @IBOutlet weak var textFieldDate: MMTextField!
    
    @IBOutlet weak var textFieldCardHolder: MMTextField!
    @IBOutlet weak var collectionViewVisaCard: UICollectionView!
    
    let collectionFlowLayout = UICollectionViewFlowLayout()
    override class func awakeFromNib() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTextField()
        
        registerCell()
        iCoresalView.type = .rotary

    }
    
    
    
    fileprivate func registerCell(){
        iCoresalView.delegate = self
        iCoresalView.dataSource = self
//        collectionViewVisaCard.delegate = self
//        collectionViewVisaCard.dataSource = self
        
//        collectionViewVisaCard.registerForCell(identifier: VisaCardCollectionViewCell.identifier)
        

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
    
    
//extension PaymentMethodViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        //configureCollectionViewLayoutItemSize()
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueCell(identifier: VisaCardCollectionViewCell.identifier, indexPath: indexPath)
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let _ = collectionView.bounds.width/1.3
//        let _ = CGFloat(200)
//
////        return CGSize(width: collectionView.contentOffset.x + collectionView.bounds.width / 2, height: collectionView.bounds.height / 2)
//
//        return CGSize(width:collectionView.bounds.width/1, height: CGFloat(200))
//    }
//
//
}

extension PaymentMethodViewController : iCarouselDelegate, iCarouselDataSource{
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 3
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width / 1, height: parentSize.height)
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        //let cell = VisaCardCollectionViewCell()
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: view?.bounds.width ?? 50 / 0.8, height: view?.bounds.height ?? 200 ))
       
        tempView.backgroundColor = .gray
        
        return tempView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing{
            return value * 0.8
        }
        return value
    }
    
    
    
    
}
