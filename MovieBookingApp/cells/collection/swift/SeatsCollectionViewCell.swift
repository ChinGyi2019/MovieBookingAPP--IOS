//
//  SeatsCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 05/06/2021.
//

import UIKit

class SeatsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var seatText: UILabel!
    @IBOutlet weak var seatView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func bindData(movieSeat : MovieSeatVO){
        seatText.text = movieSeat.title
        
        if movieSeat.isSeatTypeText(){
            //Text
            seatView.layer.cornerRadius = 0
            seatView.backgroundColor = UIColor.white
            
        } else if movieSeat.isSeatTypeTaken(){
            //Taken
            seatText.text = "     "
            seatView.clipsToBounds = true
            seatView.backgroundColor = UIColor(named: "color_seat_taken") ?? UIColor.gray
            seatView.layer.cornerRadius = 8
            seatView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
            
        } else if movieSeat.isSeatTypeAvailable(){
            //Available
            seatText.text = "     "
            seatView.clipsToBounds = true
            seatView.backgroundColor = UIColor(named: "color_seat_available") ?? UIColor.lightGray
            seatView.layer.cornerRadius = 8
            seatView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
        } else{
            seatView.layer.cornerRadius = 0
            seatView.backgroundColor = UIColor.white
        }
        
        
    }

}
