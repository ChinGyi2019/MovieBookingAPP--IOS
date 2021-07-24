//
//  SeatTicketsCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 13/07/2021.
//

import UIKit

class SnackCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var stackViewMinuPlus: UIStackView!
    @IBOutlet weak var lblAmount: UILabel!
    
    @IBOutlet weak var lblSnackDescription: UILabel!
    @IBOutlet weak var lblSnackName: UILabel!
    @IBOutlet weak var lblSnackPirce: UILabel!
    @IBAction func didTapPlusBtn(_ sender: Any) {
        onTapPlus(data?.id ?? -1)
        //delegate?.plus(snackId: data?.id ?? -1)
    }
    @IBAction func didTapMinusBtn(_ sender: Any) {
        onTapMinus(data?.id ?? -1)
        //delegate?.minus(snackId: data?.id ?? -1)
    }
    
    
    var onTapPlus : ((Int)->Void) = {_ in }
    var onTapMinus : ((Int)->Void) = {_ in }
    

    
    var data : Snack?{
        didSet{
            if let snack = data{
                lblSnackName.text = snack.name
                lblSnackDescription.text = snack.datumDescription
                
                lblSnackPirce.text = "\(snack.price ?? 0)  $"
                lblAmount.text = "\(data?.amount ?? 0)"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       setUpPlusMnusView()
    }
    
    fileprivate func setUpPlusMnusView(){
        stackViewMinuPlus.addBorderLine(radius: 8, width: 1, color: UIColor.gray.cgColor)
        lblAmount.addBorderLine(radius: 0, width: 1, color: UIColor.gray.cgColor)
    }

}
