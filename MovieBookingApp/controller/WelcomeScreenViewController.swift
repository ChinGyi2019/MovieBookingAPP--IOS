//
//  WelcomeScreenViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 07/06/2021.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    @IBOutlet weak var btnGetStarted: UIButton!
    
  
    @IBAction func ditTapGetStartedBtn(_ sender: Any) {
        navigateFormWelcomeScreenToAuthScreen()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        
    }
    
    fileprivate func initView(){
        btnGetStarted.addBorderLine(radius: 8, width: 1, color: UIColor.white.cgColor)
        
        navigationController?.navigationBar.isHidden = true
    }
    

   

}
