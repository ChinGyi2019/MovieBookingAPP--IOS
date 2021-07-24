//
//  MovieCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 07/06/2021.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblMovieName : UILabel!
    @IBOutlet weak var lblMovieGenreAndDuration : UILabel!
    @IBOutlet weak var ivMovieBackDrop : UIImageView!
    
    var data : MovieResult?{
        didSet{
            if let data = data {
                
                let backDropPath = "\(AppConstants.BASE_IMG_URL)/\( data.posterPath ?? "")"
                
                ivMovieBackDrop.sd_setImage(with: URL(string: backDropPath))
                lblMovieName.text = data.originalTitle ?? ""
                var genreString = ""
                data.genres?.forEach({ genre in
                    genreString += "\(genre), "
                })
                if genreString != "" {
                    genreString.removeLast()
                    genreString.removeLast()
                }
                lblMovieGenreAndDuration.text = genreString
                
                
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
