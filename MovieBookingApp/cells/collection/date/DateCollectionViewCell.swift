//
//  DateCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 03/06/2021.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var hostUIView : UIView!
    @IBOutlet weak var lblWeekDays : UILabel!
    @IBOutlet weak var lblDays : UILabel!
    
    var onTapItem : ((String)->Void) = {_ in }
    
    var data : DateModel? {
        didSet{
            if let data = data {
                lblWeekDays.text = data.date.dayOfWeek()
                lblDays.text =  data.date.onlyDay
                if data.isSelected{
                    lblDays.textColor = .white
                    lblWeekDays.textColor = .white
                }else{
                    lblDays.textColor = .gray
                    lblWeekDays.textColor = .gray
                }
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapGestureForContainer = UITapGestureRecognizer(target: self, action: #selector(didTabItem))
        hostUIView.isUserInteractionEnabled = true
        hostUIView.addGestureRecognizer(tapGestureForContainer)
    }
    
    @objc func didTabItem(){
        self.onTapItem(data?.date.formattedDate ?? "")
    }

}
