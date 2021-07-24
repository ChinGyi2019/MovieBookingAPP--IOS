//
//  MovieDetailsViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 08/06/2021.
//

import Foundation
import UIKit

class MovieDetailsViewController: UIViewController {
    
    
    
    
    @IBAction func ditTapGetYourTicketBtn(_ sender: Any) {
        
        navigateFormMovieDetailsScreenToDateChoosingScreen(movieId: movieID, movieName: movieName)
    }
    
    @IBOutlet weak var collectionViewCast: UICollectionView!
    @IBOutlet weak var collectionViewGenre: UICollectionView!
    
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var imdbRation: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var ivBackDrop: UIImageView!
    
    @IBOutlet weak var rationControl: RatingControl!
    
    
    
    
    
    var movieID : Int = -1
    var movieName : String = ""
    private let networkingAgent = AFNetworkingAgent.shared
    private var casts = [Cast]()
    private var genres = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        fetchMovieDetails(id: movieID)
    }
    
    fileprivate func initView(){
        
        print(movieID)
        setUpDataSourceAndDelegate()
        
        registerCell()
    }
    
    
    fileprivate func setUpDataSourceAndDelegate(){
        collectionViewCast.dataSource = self
        collectionViewCast.delegate = self
        
        collectionViewGenre.dataSource = self
        collectionViewGenre.delegate = self
    }
    
    fileprivate func registerCell(){
        collectionViewGenre.registerForCell(identifier: MoveGenreCollectionViewCell.identifier)
        collectionViewCast.registerForCell(identifier: CastsCollectionViewCell.identifier)
    }
    
    
    //MARK:- FetchMovieDetails
    fileprivate func fetchMovieDetails(id : Int){
        networkingAgent.fetchMovieDetails(movieId: id) { response in
            switch response {
            case .success(let data):
                self.bindDetails(data)
            case .error(let error):
                debugPrint(error)
            }
        }
    }
    
    fileprivate func bindDetails(_ data : MovieDetailsResponse){
        
        let backDropPath = "\(AppConstants.BASE_ORIGINAL_IMG_URL)/\(data.data?.posterPath ?? "")"
        
        ivBackDrop.sd_setImage(with: URL(string: backDropPath))
        //Casts
        casts = data.data?.casts ?? [Cast]()
        collectionViewCast.reloadData()
        
        //Genre
        genres = data.data?.genres ?? [String]()
        debugPrint(genres)
        collectionViewGenre.reloadData()
        
        lblMovieTitle.text = data.data?.originalTitle
        movieName = data.data?.originalTitle ?? ""
        
        navigationItem.title = data.data?.originalTitle
        lblDescription.text = data.data?.overview
        let runTime = data.data?.runtime ?? 0
        let runHour : Int = runTime / 60
        let runMinute : Int = runTime % 60
        lblDuration.text = "\(runHour)h \(runMinute)m"
        imdbRation.text = "IMDb \(data.data?.rating ?? 0)"
        
        rationControl.starCount = 5
        rationControl.rating = Int((data.data?.rating ?? 0.0) * 0.5)
        
    }
    
    
    
}
extension MovieDetailsViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionViewCast{
            return casts.count
        }else if collectionView == collectionViewGenre{
            return genres.count
        }else{
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewCast{
            let cell = collectionView.dequeueCell(identifier: CastsCollectionViewCell.identifier, indexPath: indexPath) as CastsCollectionViewCell
            cell.data = casts[indexPath.row]
            return cell
        }else if collectionView == collectionViewGenre{
            let cell = collectionView.dequeueCell(identifier: MoveGenreCollectionViewCell.identifier, indexPath: indexPath) as MoveGenreCollectionViewCell
            cell.data = genres[indexPath.row]
            return cell
        }else{
          return  UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionViewCast{
            return CGSize(width: CGFloat(64), height: CGFloat(64))
        }else if collectionView == collectionViewGenre{
            let width  = collectionView.bounds.width / 5
            let height = collectionView.bounds.height
            return CGSize(width: width, height: height)
        }else{
            return CGSize(width: 0, height: 0)
        }
        
        
        
    }
    
    
}


