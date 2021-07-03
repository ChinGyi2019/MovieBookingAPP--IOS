//
//  MovieSeatViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 05/06/2021.
//

import Foundation
import UIKit

class MovieSeatViewController: UIViewController {
    
    
    @IBAction func didTapBackBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

   
    @IBAction func didTapBuyTicketBtn(_ sender: Any) {
        debugPrint("Clicked")
        navigateFormSeatsChoosingScreenToBillingScreen()
        
    }
    @IBOutlet weak var collectionViewSeats: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //registerCell
        register()
        
        //setUpDataSoutceAndDelegate
        setUpDataSourceAndDelegate()
        
    }
    
    fileprivate func register() {
        collectionViewSeats.registerForCell(identifier: SeatsCollectionViewCell.identifier)
    }
    
    fileprivate func setUpDataSourceAndDelegate(){
        collectionViewSeats.delegate = self
        collectionViewSeats.dataSource = self
    }
    
    
}

extension MovieSeatViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        seatDummyData.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(identifier: SeatsCollectionViewCell.identifier, indexPath: indexPath) as! SeatsCollectionViewCell
        cell.bindData(movieSeat: seatDummyData[indexPath.row])
        return cell
    }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width/10
        let height = CGFloat(40)
        return CGSize(width: width, height: height)
    }
    
    
}


