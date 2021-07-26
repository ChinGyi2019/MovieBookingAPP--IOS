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
        
        navigateFromPaymentMethodScreenToGettingTicketScreen(totalPrice: totalPrice, movieID: movieID, timeSlotID: timeSlotID, cinemaID: cinemaID, selectedSeats: selectedSeats, selectedSnacks: selectedSnacks, bookingDate: bookingDate, selectedCardId: selectedCardId)
    }
   
    
    @IBAction func didTapAddCardBtn(_ sender: Any) {
        checkTextFieldEmpty {
           let cardNumber = textFieldCardNumber.text
           let cardHolderName = textFieldCardHolder.text
           let cardCVC = textFieldCVC.text
           let cardExpiredDate = textFieldDate.text
            
           addNewCard(Card(id: nil, cardHolder: cardHolderName, cardNumber: cardNumber, expirationDate: cardExpiredDate, cardType: nil, cvc: cardCVC))
        }
        
    }
    @IBAction func didTapAddNewCard(_ sender: Any) {
    
        if stackViewNewCard.isHidden{
            stackViewNewCard.isHidden = false
            confirmCardAddBtn.isHidden = false
            addNewBtn.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
            addNewBtn.setTitle("Cancel", for: .normal)
        }else{
            stackViewNewCard.isHidden = true
            confirmCardAddBtn.isHidden = true
            addNewBtn.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
            stackViewNewCard.isHidden = true
            addNewBtn.setTitle("Add New Card", for: .normal)
          
        }
       
    }
    
    @IBOutlet weak var textFieldCardNumber: MMTextField!
    @IBOutlet weak var textFieldCVC: MMTextField!
    @IBOutlet weak var textFieldDate: MMTextField!
    @IBOutlet weak var textFieldCardHolder: MMTextField!
    
    @IBOutlet weak var lblTotalPrice : UILabel!
    @IBOutlet weak var collectionViewVisaCard: UICollectionView!
    @IBOutlet weak var addNewBtn: UIButton!
    
    @IBOutlet weak var confirmCardAddBtn: UIButton!
    @IBOutlet weak var stackViewNewCard: UIStackView!
    
    let collectionFlowLayout = UICollectionViewFlowLayout()
    
    
    
    
    var movieID : Int = -1
    var cinemaID: Int = -1
    var timeSlotID: Int = -1
    var selectedSeats = [MovieSeatVO]()
    var bookingDate : Date? = nil
    var selectedSnacks = [Snack]()
    var totalPrice : Double = 0.0
    var selectedCardId : Int = -1
    
    var pyamentModel : PaymentModel = PaymentModelImpl.shared
    var cards = [Card]()
    
    
    override class func awakeFromNib() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
       

    }
    
    fileprivate func initView(){
        navigationItem.title = "Choose Visa"
        lblTotalPrice.text = "$ \(totalPrice)"
        setUpTextField()
        
        registerCell()
        iCoresalView.type = .rotary
        confirmCardAddBtn.isHidden = true
        
        
        
        
        fetchCard()
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
    
    fileprivate func fetchCard(){
        pyamentModel.getProfile { result in
            switch result{
            case .success(let data):
                self.cards =  data.data?.cards ?? [Card]()
                self.iCoresalView.reloadData()
                if !self.cards.isEmpty{
                    self.selectedCardId = self.cards[self.iCoresalView.currentItemIndex].id  ?? -1
                    print(self.selectedCardId)
                }
                
            case .error(let error):
                print(error)
            }
        }
    }
    
    fileprivate func addNewCard(_ card : Card){
        
        
        pyamentModel.addNewCard(card: card) { result in
            switch result{
            case .success(let cards):
                self.bindNewCardData(cards)
                
            case .error(let error):
                print(error)
            }
        }
    }
    
    fileprivate func bindNewCardData(_ card : AddNewCardResponse){
        self.cards =  card.data ?? [Card]()
        self.iCoresalView.reloadData()
        if !self.cards.isEmpty{
            selectedCardId = self.cards[iCoresalView.currentItemIndex].id  ?? -1
            print(selectedCardId)
        }
            
        //Success  - reset View
        stackViewNewCard.isHidden = true
        confirmCardAddBtn.isHidden = true
        stackViewNewCard.isHidden = true
        addNewBtn.setTitle("Add New Card", for: .normal)
        
        
    }
    
    fileprivate func checkTextFieldEmpty(addNewCard : ()->Void){
        let red = UIColor(red: 100.0, green: 130.0, blue: 230.0, alpha: 1.0)
        if (textFieldCardNumber.text?.isEmpty ==  true){
            textFieldCardNumber.isError(baseColor: red.cgColor, numberOfShakes: 1.0, revert: true)
            textFieldCardNumber.placeholder = "Please Enter Card Number"
        }else if (textFieldCardHolder.text?.isEmpty == true){
            textFieldCardHolder.isError(baseColor: red.cgColor, numberOfShakes: 1.0, revert: true)
            textFieldCardHolder.placeholder = "Please Enter Card Holder Name"
        }else if (textFieldDate.text?.isEmpty == true){
            textFieldDate.isError(baseColor: red.cgColor, numberOfShakes: 1.0, revert: true)
            textFieldDate.placeholder = "Please Enter Expried Date"
        }else if (textFieldCVC.text?.isEmpty == true){
            textFieldCVC.isError(baseColor: red.cgColor, numberOfShakes: 1.0, revert: true)
            textFieldCVC.placeholder = "Please Enter Card CVC"
        }else{
            addNewCard()
        }
        
    }
    
    

}

extension PaymentMethodViewController : iCarouselDelegate, iCarouselDataSource{
    func numberOfItems(in carousel: iCarousel) -> Int {
        return cards.count
        
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width / 1, height: parentSize.height)
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
    
        let visaUIView = VisaCardView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 1.2 , height: view?.frame.height ?? 230))
        
        visaUIView.data = cards[index]
        let currentIndex = carousel.currentItemIndex
        print(cards[currentIndex])
       
        return visaUIView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing{
            return value * 0.8
        }
        return value
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        print("selectdd \(cards[index].id ?? -1)")
    }
    
    
    
    
}
