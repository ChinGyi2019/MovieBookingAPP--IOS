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
    
    
    
    
    var delegate : TimeSlotDelegate? = nil
    private var dayTimeSlotList = [Timeslot]()
    
    var data : Cinema? {
        didSet{
            if let cinema = data{
                lblCinemaName.text = cinema.cinema
                dayTimeSlotList = cinema.timeslots ?? [Timeslot]()
            
                
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
        return cell
        }
      
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 3, height: 48)
      
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if dayTimeSlotList.count > indexPath.row {
            let item = dayTimeSlotList[indexPath.row]
        
        
        let cell = collectionView.cellForItem(at: indexPath) as! TimeCollectionViewCell
        cell.uiHostView.backgroundColor = UIColor(named: "color_primary")
        cell.lblTime.textColor = .white
        
        delegate?.onTapTimeSlot(indexPath: indexPath, cinema: data!, timeSlot: item)
        }
       
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
     let  cell = collectionView.cellForItem(at: indexPath) as! TimeCollectionViewCell
        cell.uiHostView.backgroundColor = .white
        cell.lblTime.textColor = .black
        
    }
    
    
}


