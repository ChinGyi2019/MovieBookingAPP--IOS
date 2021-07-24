//
//  GettingTicketViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 08/06/2021.
//

import UIKit
import Foundation


class GettingTicketViewController: UIViewController {

    @IBAction func ditTapCancelBtn(_ sender: Any) {
    }
    @IBOutlet weak var stackViewTicket: UIStackView!
    
    @IBOutlet weak var ticketUIView: EraseCornerView!
    @IBOutlet weak var stackViewTicketInfo: UIStackView!
    
    @IBOutlet weak var ticketInfoUIView: EraseCornerView!
    
    @IBOutlet weak var barcodeUIView: EraseCornerView!
    @IBOutlet var ivTcket: UIImageView!
   
    @IBOutlet weak var stackViewBarCode: UIStackView!
    
    @IBOutlet var dashUIView: UIView!

    
    
    
    @IBOutlet var dashUIViewInTicketInofView: UIView!
    @IBAction func ditTapClosBtn(_ sender: Any) {
        weak var pvc = self.presentingViewController
        
    
        self.dismiss(animated: false, completion: {
            pvc?.performSegue(withIdentifier: "goToHome", sender: nil)
        })
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
    }
    
    fileprivate func initView(){
        navigationItem.title = "Get Your Tickets"
        let doneBarButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDoneButton))

        navigationItem.rightBarButtonItem = doneBarButton
        setUpStackViewRound()
    }
    
    @objc func didTapDoneButton(){
        print("Done Clicked")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        ticketUIView.circleY = ticketUIView.frame.height * 0.88
        ticketInfoUIView.circleY = ticketInfoUIView.frame.height * 0.85
       // barcodeUIView.circleY = barcodeUIView.frame.height

        
    }
    
     func setUpStackViewRound(){
       
        //ImageView ticket
        ivTcket.layer.cornerRadius = 16
        ivTcket.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        //Ticket UIView
        ticketUIView.layer.masksToBounds = true
        ticketUIView.circleRadius = 16.0
        ticketUIView.layer.cornerRadius = 16
        ticketUIView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        //TicketInfoUIView
        ticketInfoUIView.layer.masksToBounds = true
        ticketInfoUIView.circleRadius = 16.0
        ticketUIView.layer.cornerRadius = 16
        ticketInfoUIView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        //BarCodeUiView
        barcodeUIView.layer.masksToBounds = true
        barcodeUIView.layer.cornerRadius = 16
        barcodeUIView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        
        //DashUIView
        dashUIView.addDashedBorder()
        dashUIViewInTicketInofView.addDashedBorder()

    }
    

}
