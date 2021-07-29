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
        doCheckOut()
    }
   
    
    @IBAction func didTapAddCardBtn(_ sender: Any) {
        checkTextFieldEmpty {
           let cardNumber = textFieldCardNumber.text ?? ""
           let cardHolderName = textFieldCardHolder.text ?? ""
           let cardCVC = textFieldCVC.text ?? ""
           let cardExpiredDate = textFieldDate.text ?? ""
            let card = Card(id: nil, cardHolder: cardHolderName, cardNumber: cardNumber, expirationDate: cardExpiredDate, cardType: nil, cvc: cardCVC)
        
           addNewCard(card)
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
    var cinemaDayTimeslot : Timeslot? = nil
    var cinema : Cinema? = nil
    var selectedSeats = [MovieSeatVO]()
    var bookingDate : Date? = nil
    var selectedSnacks = [Snack]()
    var totalPrice : Double = 0.0
    var selectedCardId : Int = -1
    
    var paymentModel : PaymentModel = PaymentModelImpl.shared
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
        paymentModel.getProfile { result in
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
    
        paymentModel.addNewCard(card: card) { result in
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
           
        }
            
        //Success  - reset View
        stackViewNewCard.isHidden = true
        confirmCardAddBtn.isHidden = true
        stackViewNewCard.isHidden = true
        addNewBtn.setTitle("Add New Card", for: .normal)
        addNewBtn.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        
        
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
    
    fileprivate func doCheckOut(){
        var row = ""
        var seatNumber = ""
        //Format seat_number and row
        selectedSeats.forEach { seat in
            row += "\(seat.symbol ?? ""),"
            seatNumber += "\(seat.seatName ?? ""),"
        }
        if !row.isEmpty{
            row.removeLast()
        }
        if !seatNumber.isEmpty{
            seatNumber.removeLast()
        }
        //Call Network
        let selectedCheckOutSnack  = selectedSnacks.map{$0.toCheckOutSnack()}
        let checkOutData = CheckOutModel(cinemaDayTimeslotID: cinemaDayTimeslot?.cinemaDayTimeslotID ?? -1, row: row, seatNumber: seatNumber, bookingDate: bookingDate?.formattedDate, movieID: movieID, cardID: selectedCardId, cinemaID: cinema?.cinemaID, totalPrice: totalPrice, snacks: selectedCheckOutSnack )
        
        checkOutTicket(checkOutData)
        
    }
    
    
    fileprivate func checkOutTicket(_ checkOut : CheckOutModel){
        //Call Actual Network
        paymentModel.checkOut(checkOut: checkOut) { result in
            switch result {
            case .success(let data):
                if let code = data.code{
                    if code >= 400{
                        print(data.message ?? "checkout error")
                        self.showAlert(title: "Sorry! Ticket's Error", message: data.message ?? "")
                        return
                    }
                    //Go to Ticket Voucher
                    self.goToCheckOutScreen(data)
                
                }
                
            case .error(let error):
                self.showAlert(title: "Ticket's Error!", message: error)
                print(error)
            }
        }
        
    }
    
    fileprivate func goToCheckOutScreen(_ checkOutResponse : CheckOutResponse){
        
        if !self.cards.isEmpty{
            selectedCardId = self.cards[iCoresalView.currentItemIndex].id  ?? -1
            print(selectedCardId)
        }
        self.navigateFromPaymentMethodScreenToGettingTicketScreen(movieID: movieID, cinema: cinema ?? Cinema(), bookingDate: bookingDate, checkOutData: checkOutResponse )
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
      
       
        return visaUIView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing{
            return value * 0.8
        }
        return value
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        print("selected \(cards[index].id ?? -1)")
    }
    
    
    
    
}
