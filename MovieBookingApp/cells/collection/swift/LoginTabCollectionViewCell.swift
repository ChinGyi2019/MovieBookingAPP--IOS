//
//  LoginTabCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 25/06/2021.
//

import UIKit
import MMText


class LoginTabCollectionViewCell: UICollectionViewCell {
    @IBOutlet var textFieldEmail: MMTextField!
     @IBOutlet var textFieldPassword: MMTextField!
    
    @IBOutlet var stackViewFacebookBtn: UIStackView!
    @IBOutlet var stackViewGoogleBtn: UIStackView!
    
    var delegate : AuthDelegate? = nil
    
    @IBAction func didTapConfirmButton(_ sender: Any) {
        delegate?.didTabConfirmBtn()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mmTextView()
        setUpRoundCorners()
    }
    
    fileprivate func mmTextView(){
        //For Email TextField
        textFieldEmail.titleFont = UIFont (name: "System 14", size: 14)
        textFieldEmail.titleColor = UIColor(named: "color_seat_taken") ?? UIColor.gray

        //For Password TextField
      //  textFieldPassword.titleFont = UIFont (name: "System 14", size: 14)
       // textFieldPassword.titleColor = UIColor(named: "color_seat_taken") ?? UIColor.gray
    }
    
    fileprivate func setUpRoundCorners(){
       
        
        //Round and Add Borders
        stackViewFacebookBtn.addBorderLine(radius: 8, width: 1, color: UIColor.gray.cgColor)
        stackViewGoogleBtn.addBorderLine(radius: 8, width: 1, color: UIColor.gray.cgColor)
     
    }

}
