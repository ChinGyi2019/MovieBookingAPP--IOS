//
//  AvailableInCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 24/07/2021.
//

import UIKit

class AvailableInCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var uiHostView : UIView!
    
    var onTapItem : ((Int)->Void) = {_ in}
    
    var data : AvailableItemModel?{
        didSet{
            if let availabelIn = data{
                lblName.text =  availabelIn.name
                if availabelIn.isSelected {
                    uiHostView.backgroundColor = UIColor(named: "color_primary")
                    lblName.textColor = .white
                }else{
                    uiHostView.backgroundColor = .white
                    lblName.textColor = .black
                }
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        uiHostView.addBorderLine(radius: 4, width: 1, color: UIColor.gray.cgColor)
        setUpGestureRecognizer()
       
    }
    
    fileprivate func setUpGestureRecognizer(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onTapView))
        uiHostView.isUserInteractionEnabled = true
        uiHostView.addGestureRecognizer(gesture)
    }
    
    @objc func onTapView(){
        onTapItem(data?.id ?? -1)
    }

}
