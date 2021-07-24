//
//  ViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 02/06/2021.
//

import UIKit
import Foundation
import SDWebImage

class HomeViewController: UIViewController, MovieItemDelegate {
    
    @IBOutlet weak var collectionViewCommingSoon: UICollectionView!
    @IBOutlet weak var collectionViewNowShowing: UICollectionView!
    
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    private var nowShowingMovies = [MovieResult]()
    private var comingSoonMovies = [MovieResult]()
    
    private let itemSpacing :CGFloat = 10
    
    
    func onMovieTap(movieId : Int) {
       navigateFormHomeToMovieDetailsScreen(movieId: movieId)
    }

    private var netwrokingAgent = AFNetworkingAgent.shared
    var delegate : MovieItemDelegate? = nil
    private var userDefaultHelper = UserDefaultHelper.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        processPreNavigation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        initView()
    }
    
    fileprivate func initView(){
        //Register
        registerCell()
        //setUpDelegateAndDataSource
        setUpDelegateAndDataSource()
        
        navigationController?.navigationBar.isHidden = false
        
        //fetching Network
        fetchUserProfile()
        fetchNowShowingMovies(take: 15, status: .NowShowing)
        fetchUpComingMovies(take: 15, status: .ComingSoon)
        
    }
    
    fileprivate func processPreNavigation(){
        if !isUserAuthenticated(){
            navigateFormHomeToLoginScreen()
        }
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
    
    func  isUserAuthenticated() -> Bool {
        return userDefaultHelper.getToken().isEmpty == false && userDefaultHelper.getToken() != ""
    }
    //MARK:- Profile
    fileprivate func fetchUserProfile(){
        netwrokingAgent.getProfile { response in
            switch response{
            case .success(let data):
                self.bindProfileData(profile : data)
            case .error(let error):
                debugPrint(error)
            }
        }
    }
    
    fileprivate func fetchUpComingMovies(take : Int, status : MovieType){
        netwrokingAgent.fetchMovies(take: take, status: status.rawValue){ response in
            switch response{
            case .success(let data):
                self.bindUpComingMovies(movies : data)
            case .error(let error):
                debugPrint(error)
            }
        }
    }
    
    fileprivate func bindUpComingMovies(movies : MovieListResponse){
        comingSoonMovies = movies.data ?? [MovieResult]()
        collectionViewCommingSoon.reloadData()
        
    }
    
    fileprivate func fetchNowShowingMovies(take : Int, status : MovieType){
        netwrokingAgent.fetchMovies(take: take, status: status.rawValue){ response in
            switch response{
            case .success(let data):
                self.bindNowShowingMovies(movies : data)
            case .error(let error):
                debugPrint(error)
            }
        }
    }
    
    fileprivate func bindNowShowingMovies(movies : MovieListResponse){
        nowShowingMovies = movies.data ?? [MovieResult]()
        collectionViewNowShowing.reloadData()
    }
    
    fileprivate func bindProfileData(profile : ProfileResponse){
        let backDropPath = "\(AppConstants.BASE_URL)/\( profile.data?.profileImage ?? "")"
        
        ivProfile.sd_setImage(with: URL(string: backDropPath))
        let name : String = profile.data?.name ?? ""
        lblUserName.text = "Hi \(name)!"
    }


}

extension HomeViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewNowShowing{
            return nowShowingMovies.count
        }else{
          return  comingSoonMovies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewNowShowing{
            let item = nowShowingMovies[indexPath.row]
            delegate?.onMovieTap(movieId: item.id ?? -1)
        }else{
            let item = comingSoonMovies[indexPath.row]
            delegate?.onMovieTap(movieId: item.id ?? -1)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewNowShowing{
            let cell = collectionView.dequeueCell(identifier: MovieCollectionViewCell.identifier, indexPath: indexPath) as MovieCollectionViewCell
            cell.data = nowShowingMovies[indexPath.row]
            return cell
        }else{
            let cell = collectionView.dequeueCell(identifier: MovieCollectionViewCell.identifier, indexPath: indexPath) as MovieCollectionViewCell
            cell.data = comingSoonMovies[indexPath.row]
            
            return cell
        }
        
    }
    
    
}

extension HomeViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width/2.7
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        itemSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        itemSpacing
    }
}

