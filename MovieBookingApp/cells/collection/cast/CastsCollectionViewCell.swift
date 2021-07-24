//
//  CastsCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 08/06/2021.
//

import UIKit

class CastsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ivBackDrop : UIImageView!
    var data : Cast?{
        didSet{
            if let cast = data {
                let backDropPath = "\(AppConstants.BASE_IMG_URL)/\(cast.profilePath ?? "")"
                
                ivBackDrop.sd_setImage(with: URL(string: backDropPath))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
