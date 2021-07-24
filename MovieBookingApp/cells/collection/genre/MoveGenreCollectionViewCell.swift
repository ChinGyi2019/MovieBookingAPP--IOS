//
//  MoveGenreCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 19/07/2021.
//

import UIKit

class MoveGenreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblGenre : UILabel!
    
    var data : String? {
        didSet{
        if let genre = data{
            lblGenre.text = genre
        }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        roundLabel()
    }
    
    func  roundLabel()  {
        self.isUserInteractionEnabled = true
        self.addBorderLine(radius: 15, width: 1, color: UIColor.black.cgColor)
    }

}
