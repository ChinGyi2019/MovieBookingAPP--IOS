//
//  BillingScreenViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 08/06/2021.
//

import UIKit

class BillingScreenViewController: UIViewController {
    @IBOutlet weak var stackViewPlusMinus: UIStackView!
   

    
    @IBAction func ditTapPayBtn(_ sender: Any) {
        navigateFromBillingScreenToPaymentMethodScreen()
    }
    @IBAction func ditTapBackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var stacViewPlusMinusSecond: UIStackView!
    @IBOutlet weak var stackViewMinuPlusThird: UIStackView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblAmountThird: UILabel!
    
    @IBOutlet weak var lblAmountSecond: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpPlusMnusView()
       
    }
    
    
    fileprivate func setUpPlusMnusView(){
        stackViewPlusMinus.addBorderLine(radius: 8, width: 1, color: UIColor.gray.cgColor)
        lblAmount.addBorderLine(radius: 0, width: 1, color: UIColor.gray.cgColor)
        
        stacViewPlusMinusSecond .addBorderLine(radius: 8, width: 1, color: UIColor.gray.cgColor)
        lblAmountSecond.addBorderLine(radius: 0, width: 1, color: UIColor.gray.cgColor)
        
        stackViewMinuPlusThird.addBorderLine(radius: 8, width: 1, color: UIColor.gray.cgColor)
        lblAmountThird.addBorderLine(radius: 0, width: 1, color: UIColor.gray.cgColor)
    }
    

    

}
