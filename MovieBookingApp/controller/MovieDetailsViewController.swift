//
//  MovieDetailsViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 08/06/2021.
//

import Foundation
import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBAction func ditTapBackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
  

    @IBAction func ditTapGetYourTicketBtn(_ sender: Any) {
        navigateFormMovieDetailsScreenToDateChoosingScreen()
    }
    @IBOutlet weak var btnMystery: UIButton!
    
   
  
    @IBOutlet weak var btnAdventure: UIButton!
    
    
    @IBOutlet weak var collectionViewCast: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButtonRound()
        setUpDataSourceAndDelegate()
      //registerCell
        registerCell()
    }
    
    
    fileprivate func setUpDataSourceAndDelegate(){
        collectionViewCast.dataSource = self
        collectionViewCast.delegate = self
    }
    
    fileprivate func registerCell(){
    collectionViewCast.registerForCell(identifier: CastsCollectionViewCell.identifier)
    }
    
    fileprivate func setUpButtonRound(){
        btnMystery.addBorderLine(radius: 16, width: 1, color: UIColor.black.cgColor)
        
        btnAdventure.addBorderLine(radius: 16, width: 1, color: UIColor.black.cgColor)
    }
    

   
}
extension MovieDetailsViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(identifier: CastsCollectionViewCell.identifier, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(64), height: CGFloat(64))
    }
    
    
}


