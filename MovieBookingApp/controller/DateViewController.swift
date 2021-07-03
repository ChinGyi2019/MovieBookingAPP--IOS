//
//  DateViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 03/06/2021.
//

import Foundation
import UIKit

class DateViewController: UIViewController {
    
    
    @IBOutlet weak var scrollViewHost: UIScrollView!
    
    @IBOutlet weak var collectionViewDays: UICollectionView!
    @IBOutlet weak var collectionViewAvailableIn: UICollectionView!
    
    @IBOutlet weak var collectionViewGoldenCity: UICollectionView!
    
    @IBOutlet weak var collectionViewWestPoint: UICollectionView!
    
    @IBOutlet weak var btnNext: UIButton!
    
   
    @IBAction func didTapBackBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func ditTapNextBtn(_ sender: Any) {
        navigateFormDateChoosingScreenToSeatsChoosingScreen()
    }
    
    @IBOutlet weak var collectionViewHeightAvailableIn: NSLayoutConstraint!
    
    @IBOutlet weak var collectinViewHeightGoldenCity: NSLayoutConstraint!
    
    @IBOutlet weak var collectionViewHeightWestPoint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        //ScrollView fit
        let contentRect: CGRect = scrollViewHost.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        scrollViewHost.contentSize = contentRect.size
        self.view.layoutIfNeeded()
        
        //Register Cell
        registerCell()
        
        //SetUpDataSourceAndDelegate
        setUpDataSourcesAndDelegates()
        
        //SetUpCollectionViewHeight
        setUpCollectionViewHeight()
        
        
    }
    
    fileprivate func registerCell(){
        
        collectionViewDays.registerForCell(identifier: DateCollectionViewCell.identifier)
        collectionViewAvailableIn.registerForCell(identifier: TimeCollectionViewCell.identifier)
        collectionViewGoldenCity.registerForCell(identifier: TimeCollectionViewCell.identifier)
        collectionViewWestPoint.registerForCell(identifier: TimeCollectionViewCell.identifier)
    }
    
    fileprivate func setUpDataSourcesAndDelegates(){
    
        collectionViewDays.delegate = self
        collectionViewDays.dataSource  = self
        
        collectionViewAvailableIn.delegate = self
        collectionViewAvailableIn.dataSource = self
        
        collectionViewGoldenCity.delegate = self
        collectionViewGoldenCity.dataSource = self
        
        collectionViewWestPoint.delegate = self
        collectionViewWestPoint.dataSource = self
    }
    
    
    fileprivate func setUpCollectionViewHeight(){
        collectionViewHeightAvailableIn.constant = 56
        collectinViewHeightGoldenCity.constant = 56*2
        collectionViewHeightWestPoint.constant = 56*2
        
        //Need to call unless it won't change
        self.view.layoutIfNeeded()
    }
    
}

extension DateViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewDays{
            return 10
        }else if collectionView == collectionViewAvailableIn{
            return 3
        }else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewDays{
           return collectionView.dequeueCell(identifier: DateCollectionViewCell.identifier, indexPath: indexPath)
            
        }else{
            return collectionView.dequeueCell(identifier: TimeCollectionViewCell.identifier, indexPath: indexPath)
        }
      
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewDays{
            return CGSize(width: 60, height: 80)
        }else{
            return CGSize(width: collectionView.bounds.width / 3, height: 48)
        }
    }
    
    
    
}
