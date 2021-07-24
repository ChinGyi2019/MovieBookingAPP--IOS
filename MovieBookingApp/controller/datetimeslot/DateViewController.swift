//
//  DateViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 03/06/2021.
//

import Foundation
import UIKit

class DateViewController: UIViewController, TimeSlotDelegate {
    
    func onTapTimeSlot(indexPath : IndexPath, cinema: Cinema, timeSlot: Timeslot) {
        selectedTimeSlot = timeSlot.cinemaDayTimeslotID ?? -1
        print(selectedTimeSlot)
        
        seletedTimeSlot = timeSlot
        selectedCinema = cinema
       
        
    }
    
    
    
    @IBOutlet weak var scrollViewHost: UIScrollView!
    
    @IBOutlet weak var collectionViewDays: UICollectionView!
    @IBOutlet weak var collectionViewAvailableIn: UICollectionView!
    
    @IBOutlet weak var collectionViewGoldenCity: UICollectionView!
    
    @IBOutlet weak var collectionViewCinemaHost: UICollectionView!
    
    @IBOutlet weak var collectionViewWestPoint: UICollectionView!
    
    @IBOutlet weak var btnNext: UIButton!
    
    private var cinemas = [Cinema]()
   
   
    @IBAction func ditTapNextBtn(_ sender: Any) {
      
        navigateFormDateChoosingScreenToSeatsChoosingScreen(movieId: movieID, movieName: movieName, timeSlot: seletedTimeSlot ?? Timeslot(), cinema: selectedCinema ?? Cinema(), bookingDate: bookingDate ?? Date())
        
    }
    
    @IBOutlet weak var collectionViewHeightAvailableIn: NSLayoutConstraint!
    
    @IBOutlet weak var collectinViewHeightGoldenCity: NSLayoutConstraint!
    
    @IBOutlet weak var collectionViewHeightWestPoint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionViewCinmaHostHeight : NSLayoutConstraint!
    
    var movieID : Int = -1
    var selectedTimeSlot = -1
    var bookingDate : Date? = nil
    var selectedCinema : Cinema? = nil
    var seletedTimeSlot : Timeslot? = nil
    var movieName: String = ""
    private var availabeInItems : [AvailableItemModel] = [AvailableItemModel(id: 1, name: "2D", isSelected: true),AvailableItemModel(id: 2, name: "3D", isSelected: false),AvailableItemModel(id: 3, name: "IMAX", isSelected: false)]
    private var twoWeekDates = [DateModel]()
    private let networkingAgent = AFNetworkingAgent.shared
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        initView()
       // getCurrentDate()

    }
    
    fileprivate func setUpTwoWeeksDays(){
        let calendar = Calendar.current
        let currentDate = Date()
        let endDate = calendar.date(byAdding: .weekOfYear, value: 2, to: Date())!
        twoWeekDates = createDatesByInterval(startDate: currentDate, endDate: endDate).map{ $0.toDateModel()}
        collectionViewDays.reloadData()
        
        onTapDates(date: twoWeekDates.first?.date.formattedDate ?? "")
        
    }
    

    
    
    fileprivate func initView(){
        
        navigationItem.title = "Choose Yor Date"
        
        //ScrollView fit
        let contentRect: CGRect = scrollViewHost.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        scrollViewHost.contentSize = contentRect.size
        self.view.layoutIfNeeded()
        
        //Register Cell
        registerCell()
        
        //SetUpDataSourceAndDelegate
        setUpDataSourcesAndDelegates()
        
        //SetUpCollectionViewHeight
        setUpCollectionViewHeight()
        
        //SetUPDays
        setUpTwoWeeksDays()
       
        
    }
    
    fileprivate func registerCell(){
        
        collectionViewDays.registerForCell(identifier: DateCollectionViewCell.identifier)
        collectionViewAvailableIn.registerForCell(identifier: AvailableInCollectionViewCell.identifier)
        collectionViewCinemaHost.registerForCell(identifier: CinemaCollectionViewCell.identifier)
//        collectionViewWestPoint.registerForCell(identifier: TimeCollectionViewCell.identifier)
        
        collectionViewDays.allowsMultipleSelection = false
        collectionViewAvailableIn.allowsMultipleSelection = false
       // collectionViewCinemaHost.allowsMultipleSelection = false
    }
    
    fileprivate func setUpDataSourcesAndDelegates(){
    
        collectionViewDays.delegate = self
        collectionViewDays.dataSource  = self
        
        collectionViewAvailableIn.delegate = self
        collectionViewAvailableIn.dataSource = self
        
        collectionViewCinemaHost.delegate = self
        collectionViewCinemaHost.dataSource = self
    
    }
    
    
    fileprivate func setUpCollectionViewHeight(){
        collectionViewHeightAvailableIn.constant = 56
//        collectinViewHeightGoldenCity.constant = 56*2
//        collectionViewHeightWestPoint.constant = 56*2
        
        //Need to call unless it won't change
        self.view.layoutIfNeeded()
    }
    
    //OnTapDate Item
    fileprivate func onTapDates(date : String){
        
        self.twoWeekDates.forEach{ item in
            if item.date.formattedDate ==  date {
                item.isSelected = true
                self.bookingDate = item.date
            }else{
                item.isSelected = false
            }
        }
        collectionViewDays.reloadData()
        fetchCinemaDayTimeSlot(date: bookingDate?.formattedDate ?? Date().formattedDate, movieId: movieID)
    }
    
    //Mark:- Network
    fileprivate func fetchCinemaDayTimeSlot(date: String, movieId: Int){
        networkingAgent.fetchCinemaDayTimeSlot(movieId: movieId, date: date) { response in
            switch response{
            case .success(let data):
                self.bindCinemaCollectionView(data)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    fileprivate func bindCinemaCollectionView(_ cinema : CinemaDayTimeSlotResponse){
        cinemas = cinema.data ?? [Cinema]()
        collectionViewCinemaHost.reloadData()
    }
    
}

extension DateViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewDays{
            return twoWeekDates.count
        }else if collectionView == collectionViewCinemaHost{
            return cinemas.count
        }else if collectionView == collectionViewAvailableIn {
            return availabeInItems.count
        }else{
           return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewDays{
           let cell =  collectionView.dequeueCell(identifier: DateCollectionViewCell.identifier, indexPath: indexPath) as DateCollectionViewCell
            cell.data = twoWeekDates[indexPath.row]
            cell.onTapItem = { date in
                self.onTapDates(date: date)
            }
            return cell
            
        }else if collectionView == collectionViewCinemaHost{
            
                    let cell =  collectionView.dequeueCell(identifier: CinemaCollectionViewCell.identifier, indexPath: indexPath) as CinemaCollectionViewCell
           
            cell.data = cinemas[indexPath.row]
                    
                    cell.delegate = self
                    return cell
               
    
        }else if collectionView == collectionViewAvailableIn{
            let cell =  collectionView.dequeueCell(identifier: AvailableInCollectionViewCell.identifier, indexPath: indexPath) as AvailableInCollectionViewCell
            cell.data = availabeInItems[indexPath.row]
            cell.onTapItem = { id in
                self.availabeInItems.forEach { item in
                    if item.id == id{
                        item.isSelected = true
                    }else{
                        item.isSelected = false
                    }
                }
                self.collectionViewAvailableIn.reloadData()
                
            }
            return cell
        }else{
            return UICollectionViewCell()
        }
      
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewDays{
            
            return CGSize(width: 60, height: 80)
            
        }else if collectionView == collectionViewAvailableIn{
            
            return CGSize(width: collectionView.bounds.width / 3, height: 48)
            
        }else if collectionView == collectionViewCinemaHost{
            
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height/3)
            
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewCinemaHost{
            _ = cinemas[indexPath.row]
           // print(item.cinema)
        }
    }
    
    
    
}
