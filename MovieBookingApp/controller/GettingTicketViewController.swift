//
//  GettingTicketViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 08/06/2021.
//

import UIKit
import Foundation
import SDWebImage


class GettingTicketViewController: UIViewController {
    
    //MARK:- IBOutlet
    //GenrealView
    @IBOutlet weak var stackViewTicket: UIStackView!
    @IBOutlet weak var ticketUIView: EraseCornerView!
    @IBOutlet weak var stackViewTicketInfo: UIStackView!
    @IBOutlet weak var ticketInfoUIView: EraseCornerView!
    @IBOutlet weak var barcodeUIView: EraseCornerView!
    @IBOutlet var ivTcket: UIImageView!
    @IBOutlet weak var stackViewBarCode: UIStackView!
    @IBOutlet var dashUIView: UIView!
    //MovieTicket
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblBookingNo: UILabel!
    @IBOutlet weak var lblShowTime : UILabel!
    @IBOutlet weak var lblTheater: UILabel!
    @IBOutlet weak var lblScreen: UILabel!
    @IBOutlet weak var lblRow: UILabel!
    @IBOutlet weak var lblSeat: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var ivMovieTicketDropBack: UIImageView!
    
    //MARK:- Properties
    var movieID : Int = -1
    let golbalInstance =  Globalnstance.shared
    var checkOutData : CheckOutResponse? = nil
    var cinema : Cinema? = nil
    var bookingDate : Date? = nil
//    var moiveName : String = ""
//    var movieDuration : String = ""
   
//    var cinemaDayTimeslot : Timeslot? = nil
   
//    var selectedSeats = [MovieSeatVO]()
  
//    var selectedSnacks = [Snack]()
//    var totalPrice : Double = 0.0
//    var selectedCardId : Int = -1
    
    private let paymentModel : PaymentModel = PaymentModelImpl.shared
    private let movieModel : MovieModel = MovieModelImpl.shared
   
    
    @IBOutlet var dashUIViewInTicketInofView: UIView!
    
    //MARK:- ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
    }
    
    //MARK:- Init View
    fileprivate func initView(){
        navigationItem.title = "Get Your Tickets"
        self.navigationItem.setHidesBackButton(true, animated:true)
        let doneBarButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDoneButton))
        
        navigationItem.rightBarButtonItem = doneBarButton
        setUpStackViewRound()
        
        //Bind Tickets
        bindTicketsView(checkOutData)
        //Movie Details
        getMovieDetails(movieID: movieID)
    }
    
    @objc func didTapDoneButton(){
        print("Done Clicked")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        //Adding Cire to View
        ticketUIView.circleY = ticketUIView.frame.height * 0.88
        ticketInfoUIView.circleY = ticketInfoUIView.frame.height * 0.85
        self.view.layoutIfNeeded()
    }
    
    func setUpStackViewRound(){
        
        //ImageView ticket
        ivTcket.layer.cornerRadius = 16
        ivTcket.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        //Ticket UIView
        ticketUIView.layer.masksToBounds = true
        ticketUIView.circleRadius = 16.0
        ticketUIView.layer.cornerRadius = 16
        ticketUIView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        //TicketInfoUIView
        ticketInfoUIView.layer.masksToBounds = true
        ticketInfoUIView.circleRadius = 16.0
        ticketUIView.layer.cornerRadius = 16
        ticketInfoUIView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        //BarCodeUiView
        barcodeUIView.layer.masksToBounds = true
        barcodeUIView.layer.cornerRadius = 16
        barcodeUIView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        
        //DashUIView
        dashUIView.addDashedBorder()
        dashUIViewInTicketInofView.addDashedBorder()
        
    }
    
    fileprivate func bindTicketsView(_ ticket : CheckOutResponse?){
       
        lblBookingNo.text = ticket?.data?.bookingNo
        lblShowTime.text = bookingDate?.formattedMonthDate
        lblTheater.text = cinema?.cinema
        lblRow.text = ticket?.data?.row
        lblSeat.text = ticket?.data?.seat
        lblTotalPrice.text = ticket?.data?.total
        
    }
    
    fileprivate func getMovieDetails(movieID : Int){
        movieModel.fetchMovieDetails(movieId: movieID) { result in
            switch result {
            case .success(let data):
                self.bindMovieData(data)
            case .error(let error):
                print(error)
            }
        }
    }
    
    fileprivate func bindMovieData(_ data : MovieDetails?){
        
        let backDropPath = "\(AppConstants.BASE_ORIGINAL_IMG_URL)/\(data?.posterPath ?? "")"
        
        ivMovieTicketDropBack.sd_setImage(with: URL(string: backDropPath))
        ivMovieTicketDropBack.contentMode = .scaleToFill
        lblMovieTitle.text = data?.originalTitle
        let runTime = data?.runtime ?? 0
        let runHour : Int = runTime / 60
        let runMinute : Int = runTime % 60
        lblDuration.text = "\(runHour)h \(runMinute)m - \(golbalInstance.filmType)"
        
        
    }
    
    
}
