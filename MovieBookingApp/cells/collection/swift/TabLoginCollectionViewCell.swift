//
//  TabLoginCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 18/06/2021.
//

import UIKit

class TabLoginCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var hostUIView: UIView!
    @IBOutlet weak var indicatorUIView: UIView!
    @IBOutlet weak var lblName: UILabel!
    
    var delegate : LoginTabIndicatorDelegate? = nil
   
    var isSelectedCell = false
    
    var onTapItem : ((String)->Void) = {_ in }
    
    var data : TabViewItem? = nil {
        didSet{
            
            if let data = data{
                lblName.text = data.name
                if (data.isSelected) {
                
                    (indicatorUIView.isHidden = false)
                }else{
                    
                    (indicatorUIView.isHidden = true)
                    
                }
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureForContainer = UITapGestureRecognizer(target: self, action: #selector(didTabItem))
        hostUIView.isUserInteractionEnabled = true
        hostUIView.addGestureRecognizer(tapGestureForContainer)
        
    }

    
    @objc func didTabItem(){
        onTapItem(data?.name ?? "")
        
    }

    
}

class TabViewItem {
    
    var name : String = ""
    var isSelected : Bool = false
    
    init(name : String, isSelected : Bool) {
        self.name = name
        self.isSelected = isSelected
    }
}
