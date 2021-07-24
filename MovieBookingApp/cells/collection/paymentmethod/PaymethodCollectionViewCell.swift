//
//  PaymethodCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 13/07/2021.
//

import UIKit

class PaymethodCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblPaymentMethodName : UILabel!
    @IBOutlet weak var lblPaymentMethodDescription : UILabel!
    
    var data : PaymentMethod?{
        didSet{
            if let paymentMethod = data{
                lblPaymentMethodName.text = paymentMethod.name
                lblPaymentMethodDescription.text = paymentMethod.datumDescription
                
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
