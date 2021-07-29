//
//  CinemaCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 20/07/2021.
//

import UIKit

class CinemaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblCinemaName : UILabel!
    @IBOutlet weak var collecitonViewCinemaTiemSlot : UICollectionView!
    @IBOutlet weak var collectionViewHeight : NSLayoutConstraint!
    
    
    
    var onTapTimeSlotItem : (Timeslot, Cinema)->Void = {_,_  in}
    var delegate : TimeSlotDelegate? = nil
    
    private var dayTimeSlotList = [Timeslot]()
    
    var data : Cinema? {
        didSet{
            if let cinema = data{
                lblCinemaName.text = cinema.cinema
                dayTimeSlotList = cinema.timeslots ?? [Timeslot]()
                
                self.collecitonViewCinemaTiemSlot.reloadData()
                
            }
        }
    
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initView()
    }
    
    fileprivate func initView(){
        registerCell()
        
    }
    
    fileprivate func registerCell(){
        collecitonViewCinemaTiemSlot.delegate = self
        collecitonViewCinemaTiemSlot.dataSource = self
        
        collecitonViewCinemaTiemSlot.registerForCell(identifier: TimeCollectionViewCell.identifier)
        collecitonViewCinemaTiemSlot.allowsMultipleSelection = false
    }

}

extension CinemaCollectionViewCell : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dayTimeSlotList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell =  collectionView.dequeueCell(identifier: TimeCollectionViewCell.identifier, indexPath: indexPath) as TimeCollectionViewCell
        cell.data = dayTimeSlotList[indexPath.row]
        cell.onTapTimeSlotItem = {timeSlot in
            
            self.data?.timeslots?.forEach{ timeSlotItem in
                
                if timeSlotItem.cinemaDayTimeslotID ==  timeSlot.cinemaDayTimeslotID {
                  //  timeSlotItem.isSelected = true
                    self.onTapTimeSlotItem(timeSlot, self.data ?? Cinema())
                }
                 
            }
            
            
        }
        return cell
        }
      
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 3, height: 48)
      
    }

    
    
}


