//
//  MovieSeatViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 05/06/2021.
//

import Foundation
import UIKit

class MovieSeatViewController: UIViewController {
    
    
    
    @IBOutlet weak var lblSeatsName : UILabel!
    @IBOutlet weak var lblTicketAmount : UILabel!
    @IBOutlet weak var lblMovieTitle : UILabel!
    @IBOutlet weak var lblCinemaName : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    
    @IBOutlet weak var buyTicketBtn : UIButton!
    @IBAction func didTapBuyTicketBtn(_ sender: Any) {
        
        if selectedSeats.isEmpty{
            showAlert(title: "Hello !", message: "Please Select Seats!")
          
        }else{
        
            navigateFormSeatsChoosingScreenToBillingScreen(totalPrice: totalPrice, movieID: movieID, timeSlot: cinemaDayTimeslot ?? Timeslot(), cinema: cinema ?? Cinema(), selectedSeats: selectedSeats, bookingDate: bookingDate)
        }
        
       
        
    }
    @IBOutlet weak var collectionViewSeats: UICollectionView!
    
    private let networkingAgent = AFNetworkingAgent.shared
    
    var bookingDate : Date? = nil
    var movieID : Int = -1
    var movieName : String = ""
    var cinemaDayTimeslot : Timeslot? = nil
    var cinema : Cinema? = nil
    var seats = [MovieSeatVO]()
    var totalPrice : Double = 0.0
    
    var selectedSeats = [MovieSeatVO]() {
        didSet{
           
            bindSeatAndTicketsData()
            
        }
        
    }
    
    private var itemSpacing : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initView()
        
        fetchCinemaSeatingPlan(timeSlotId: cinemaDayTimeslot?.cinemaDayTimeslotID ?? -1, bookingDate: bookingDate?.formattedDate ?? "")
    }
    
    fileprivate func initView(){
        navigationItem.title = "Choose with Your Partner"
        register()
        
        //setUpDataSoutceAndDelegate
        setUpDataSourceAndDelegate()
        bindMovieData()
    }
    
    fileprivate func register() {
        collectionViewSeats.registerForCell(identifier: SeatsCollectionViewCell.identifier)
    }
    
    fileprivate func setUpDataSourceAndDelegate(){
        collectionViewSeats.delegate = self
        collectionViewSeats.dataSource = self
        collectionViewSeats.allowsMultipleSelection = true
    }
    
    fileprivate func bindMovieData(){
        lblCinemaName.text = cinema?.cinema
        lblMovieTitle.text = movieName
        lblDate.text = "\(bookingDate?.formattedMonthDate  ?? "") - \(String(describing: cinemaDayTimeslot?.startTime ?? ""))"
    }
    fileprivate func bindSeatAndTicketsData(){
        lblTicketAmount.text = "\(selectedSeats.count)"
        var selectedSeatName = ""
        
        if selectedSeats.isEmpty{
            totalPrice = 0.0
            lblSeatsName.text = selectedSeatName
            buyTicketBtn.setTitle("Buy Ticket for $ \(totalPrice)", for: .normal)
        }else{
            totalPrice = 0.0
            selectedSeats.forEach { seat in
                
                totalPrice += Double(seat.price ?? 0)
                selectedSeatName += "\(seat.seatName ?? ""), "
            }
            if !selectedSeatName.isEmpty{
                selectedSeatName.removeLast()
                selectedSeatName.removeLast()
            }
            lblSeatsName.text = selectedSeatName
            buyTicketBtn.setTitle("Buy Ticket for $ \(totalPrice)", for: .normal)
        }
    }
    
    
    //MARK: - Network
    func fetchCinemaSeatingPlan(timeSlotId : Int, bookingDate : String) {
        networkingAgent.fetchCinemaSeatingPlan(bookingDate: bookingDate, timeSlotId: timeSlotId) { result in
            switch result{
            case .success(let data):
                data.data?.forEach{list in
                    self.seats.append(contentsOf: list)
                }
                
                self.collectionViewSeats.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
    
    
}

extension MovieSeatViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        seats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(identifier: SeatsCollectionViewCell.identifier, indexPath: indexPath) as! SeatsCollectionViewCell
        cell.bindData(movieSeat: seats[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width/14
        let height = CGFloat(35)
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = seats[indexPath.row]
        selectedSeats.append(item)
        print(item.seatName ?? "")
        let cell = collectionViewSeats.cellForItem(at: indexPath) as? SeatsCollectionViewCell
        let id = (item.id ?? 1) - 1
        
        cell?.seatText.text = "\(id)"
        cell?.seatText.textColor = .white
        cell?.seatView.backgroundColor = UIColor(named: "color_primary")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let item = seats[indexPath.row]
        
        let result = selectedSeats.filter { $0.id != item.id}
        selectedSeats = result
        
        print(item.seatName ?? "")
        let cell = collectionViewSeats.cellForItem(at: indexPath) as? SeatsCollectionViewCell
        cell?.seatText.text = ""
        cell?.seatView.backgroundColor = UIColor(named: "color_seat_available")
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        itemSpacing
    }
    
    
}


