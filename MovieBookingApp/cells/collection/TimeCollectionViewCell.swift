//
//  TimeCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 03/06/2021.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var uiHostView: UIView!
    
    var onTapTimeSlotItem : (Timeslot)->Void = {_ in}
    
    var data : Timeslot? {
        didSet{
            if let timeSlot = data{
                lblTime.text = timeSlot.startTime
                
                if timeSlot.isSelected{
                    uiHostView.backgroundColor = UIColor(named: "color_primary")
                    lblTime.textColor = .white
                }else{
                    uiHostView.backgroundColor = .white
                    lblTime.textColor = .black
                }
            }
        }
    }
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        uiHostView.addBorderLine(radius: 8, width: 1, color: UIColor.gray.cgColor)
        setUpGestureTapForUiHost()
    }
    
    fileprivate func setUpGestureTapForUiHost(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onTapItem))
        uiHostView.isUserInteractionEnabled = true
        uiHostView.addGestureRecognizer(gesture)
    }
    @objc func onTapItem(){
        onTapTimeSlotItem(data ?? Timeslot())
    }
    
    

}
