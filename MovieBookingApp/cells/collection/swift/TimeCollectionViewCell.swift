//
//  TimeCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 03/06/2021.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var uiHostView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        uiHostView.addBorderLine(radius: 8, width: 1, color: UIColor.gray.cgColor)
    }

}
