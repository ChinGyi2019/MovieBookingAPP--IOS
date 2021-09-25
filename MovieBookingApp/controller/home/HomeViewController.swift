//
//  ViewController.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 02/06/2021.
//

import UIKit
import Foundation
import SDWebImage
import RxSwift

class HomeViewController: UIViewController, MovieItemDelegate {
    //MARK:- IBOutlet
    @IBOutlet weak var collectionViewCommingSoon: UICollectionView!
    @IBOutlet weak var collectionViewNowShowing: UICollectionView!
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    
    //MARK:- Deletate
    func onMovieTap(movieId : Int) {
        navigateFormHomeToMovieDetailsScreen(movieId: movieId)
    }
    
    //MARK:- Properties
    private var delegate : MovieItemDelegate? = nil
    private var movieModel : MovieModel = MovieModelImpl.shared
    private var userModel : UserModel = UserModelImpl.shared
    private var userDefaultHelper = UserDefaultHelper.shared
    private var nowShowingMovies = [MovieResult]()
    private var comingSoonMovies = [MovieResult]()
    
    private let itemSpacing :CGFloat = 10
    
    private let disposeBag = DisposeBag()
    private let movieRepository = MovieRepositoryImpl.shared
    private let refreshController = UIRefreshControl()
    
    //MARK:- LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        processPreNavigation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    //MARK:- ViewInit
    fileprivate func initView(){
        //Register
        registerCell()
        //setUpDelegateAndDataSource
        setUpDelegateAndDataSource()
        
        navigationController?.navigationBar.isHidden = false
        
        //fetching Network
        
        fetchData()
        fetchUserProfile()
        
        //Delete first three After 5s
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            self.movieRepository.delete(type: .ComingSoon)
        })
        
        
    }
    
    private func fetchData(){
        
        fetchNowShowingMovies(take: 5, status: .NowShowing)
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
    //MARK:- authentiacte
    func  isUserAuthenticated() -> Bool {
        return userDefaultHelper.getToken().isEmpty == false && userDefaultHelper.getToken() != ""
    }
    
    //MARK:- Profile
    fileprivate func fetchUserProfile(){
        userModel.getProfile { response in
            switch response{
            case .success(let data):
                self.bindProfileData(profile : data)
            case .error(let error):
                debugPrint(error)
            }
        }
    }
    
    fileprivate func bindProfileData(profile : UserData?){
        
        let backDropPath = "\(AppConstants.BASE_URL)/\( profile?.profileImage ?? "")"
        ivProfile.sd_setImage(with: URL(string: backDropPath))
        let name : String = profile?.name ?? ""
        lblUserName.text = "Hi \(name)!"
    }
    
    //MARK:- Movies
    fileprivate func fetchUpComingMovies(take : Int, status : MovieType){
//
        movieModel.fetchMovies(take: take, status: status)
            .subscribe(onNext: { data in
                self.bindUpComingMovies(movies : data)
            })
            .disposed(by: disposeBag)
//
//        movieModel.fetchMovies(take: take, status: status){ response in
//            switch response{
//            case .success(let data):
//                self.bindUpComingMovies(movies : data)
//            case .error(let error):
//                debugPrint(error)
//            }
//        }
    }
    
    
    
    fileprivate func bindUpComingMovies(movies : [MovieResult]){
        comingSoonMovies = movies
        collectionViewCommingSoon.reloadData()
        
    }
    
    fileprivate func fetchNowShowingMovies(take : Int, status : MovieType){
        
        movieModel.fetchMovies(take: take, status: status)
            .subscribe(onNext: { data in
                self.bindNowShowingMovies(movies : data)
            })
            .disposed(by: disposeBag)
        
//        movieModel.fetchMovies(take: take, status: status){ response in
//            switch response{
//            case .success(let data):
//                self.bindNowShowingMovies(movies : data)
//            case .error(let error):
//                debugPrint(error)
//            }
//        }
    }
    
    fileprivate func bindNowShowingMovies(movies : [MovieResult]){
        nowShowingMovies = movies
        collectionViewNowShowing.reloadData()
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

