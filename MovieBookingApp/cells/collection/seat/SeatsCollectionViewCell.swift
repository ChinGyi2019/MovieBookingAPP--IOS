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
       
        
        if movieSeat.isSeatTypeText(){
            //Text
            self.isUserInteractionEnabled = false
            seatText.text = movieSeat.symbol
            seatView.layer.cornerRadius = 0
            seatView.backgroundColor = UIColor.white
            
        } else if movieSeat.isSeatTypeTaken(){
            //Taken
            self.isUserInteractionEnabled = false
            seatText.text = ""
            seatView.clipsToBounds = true
            seatView.backgroundColor = UIColor(named: "color_secondary") ?? UIColor.black
            seatView.layer.cornerRadius = 10
            seatView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
            
        } else if movieSeat.isSeatTypeAvailable(){
            //Available
            seatText.text = ""
            seatView.clipsToBounds = true
            seatView.backgroundColor = UIColor(named: "color_seat_available") ?? UIColor.lightGray
            seatView.layer.cornerRadius = 10
            seatView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
        } else{
            seatText.text = ""
            self.isUserInteractionEnabled = false
            seatView.layer.cornerRadius = 0
            seatView.backgroundColor = UIColor.white
        }
        
        
    }

}
