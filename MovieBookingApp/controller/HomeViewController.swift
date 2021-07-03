//
//  ViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 02/06/2021.
//

import UIKit
import Foundation

class HomeViewController: UIViewController, MovieItemDelegate {
    func onMovieTap() {
       navigateFormHomeToMovieDetailsScreen()
    }
    
    
    
   
    @IBOutlet weak var collectionViewCommingSoon: UICollectionView!
    @IBOutlet weak var collectionViewNowShowing: UICollectionView!
    
    var delegate : MovieItemDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Register
        registerCell()
        //setUpDelegateAndDataSource
        setUpDelegateAndDataSource()
        
        
    }
    
    fileprivate func setUpDelegateAndDataSource(){
        //Comming Soon
        collectionViewCommingSoon.delegate = self
        collectionViewCommingSoon.dataSource = self
        //Now Showing
        collectionViewNowShowing.delegate = self
        collectionViewNowShowing.dataSource = self
        
        //MovieItem Click Delegate
        delegate = self
    }
    
     func registerCell(){
        collectionViewNowShowing.registerForCell(identifier: MovieCollectionViewCell.identifier)
        //Comming Soon
        collectionViewCommingSoon.registerForCell(identifier: MovieCollectionViewCell.identifier)
    }


}

extension HomeViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onMovieTap()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(identifier: MovieCollectionViewCell.identifier, indexPath: indexPath)
        return cell
    }
    
    
}

extension HomeViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width/2.5
        let height = CGFloat(270)
        return CGSize(width: width, height: height)
    }
}

