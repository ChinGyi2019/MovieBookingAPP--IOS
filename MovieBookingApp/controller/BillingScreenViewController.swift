//
//  BillingScreenViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 08/06/2021.
//

import UIKit

class BillingScreenViewController: UIViewController {

   

    
    @IBAction func ditTapPayBtn(_ sender: Any) {
        navigateFromBillingScreenToPaymentMethodScreen()
    }
  
    
    @IBOutlet weak var collectionViewSnacks : UICollectionView!
    @IBOutlet weak var collectionPaymentMethod : UICollectionView!
    @IBOutlet weak var lblSubTotalPrice : UILabel!
    @IBOutlet weak var payButton : UIButton!
    
    private let paymentModel : PaymentModel = PaymentModelImpl.shared
    
    private var snacks = [Snack]()
    private var paymentMethodList = [PaymentMethod]()
    var totalPrice : Double = 0.0
    var movieID : Int = -1
    var cinemaID: Int = -1
    var selectedSeats = [MovieSeatVO]()
    var bookingDate : Date? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    
    }
    
    fileprivate func initView(){
        navigationItem.title = "Billing Time"
        registerCell()
        
        fetchSnacks()
        
        fetchPaymethods()
        
        bindTotalPriceData()
    }
    
    fileprivate func registerCell(){
        
        collectionViewSnacks.dataSource = self
        collectionViewSnacks.delegate = self
        collectionViewSnacks.registerForCell(identifier: SnackCollectionViewCell.identifier)
        
        collectionPaymentMethod.dataSource = self
        collectionPaymentMethod.delegate = self
        collectionPaymentMethod.registerForCell(identifier: PaymethodCollectionViewCell.identifier)
    }
    
    
    private func fetchSnacks(){
        paymentModel.fetchSnackList { result in
            switch result{
            case .success(let data):
                self.bindSnackCollection(data)
            case .error(let error):
                print(error)
            }
        }
    }
    
    private func bindSnackCollection(_ snack : SnackListResponse){
        
        snacks = snack.data ?? [Snack]()
        collectionViewSnacks.reloadData()
    }
    
    
    private func fetchPaymethods(){
        paymentModel.fetchPaymentMethods{ result in
            switch result{
            case .success(let data):
                self.bindPaymentMethodCollection(data)
            case .error(let error):
                print(error)
            }
        }
    }
    
    private func bindPaymentMethodCollection(_ data : PaymentMethodListResponse){
        
        paymentMethodList = data.data ?? [PaymentMethod]()
        collectionPaymentMethod.reloadData()
    }
    
    private func bindTotalPriceData(){
        lblSubTotalPrice.text = "Sub TotalPrice : \(totalPrice)$"
        payButton.setTitle("Pay $ \(totalPrice)", for: .normal)
        
    }
    
    func didTapPlus(snackId: Int) {
        print(snackId)
        snacks.forEach { item in
            if item.id == snackId{
                item.amount = ((item.amount) + 1)
            }
        }
        collectionViewSnacks.reloadData()
    }
    
    func didTapMinus(snackId: Int) {
        print(snackId)
        snacks.forEach { item in
            if item.id == snackId{
                if(item.amount <= 0){
                    item.amount = 0
                }else{
                    item.amount = item.amount - 1
                }
               
            }
        }
        collectionViewSnacks.reloadData()
    }
    
    

    

}
//MARK:- Extension DataSource for Seat-Tickets
extension BillingScreenViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewSnacks{
            return snacks.count
        }else if collectionView == collectionPaymentMethod{
            return paymentMethodList.count
            
        }else{
           return 0
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewSnacks{
            let cell = collectionView.dequeueCell(identifier: SnackCollectionViewCell.identifier, indexPath: indexPath) as SnackCollectionViewCell
        
            cell.onTapPlus = { id in
                self.didTapPlus(snackId: id)
            }
            cell.onTapMinus = { id in
                self.didTapMinus(snackId: id)
            }
            cell.data = snacks[indexPath.row]
            
            return cell
        }else if collectionView == collectionPaymentMethod{
            let cell = collectionView.dequeueCell(identifier: PaymethodCollectionViewCell.identifier, indexPath: indexPath) as PaymethodCollectionViewCell
            cell.data = paymentMethodList[indexPath.row]
            
            return cell
        }else{
            return UICollectionViewCell()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionViewSnacks{
            let width = collectionView.frame.width
            let height = collectionView.frame.height/3
            return CGSize(width: width, height: height)
            
        }else if collectionView == collectionPaymentMethod{
            let width = collectionView.frame.width
            let height = collectionView.frame.height/3
            return CGSize(width: width, height: height)
        }else{
            return CGSize(width: 0, height: 0)
        }
       
    }
    
    
}


