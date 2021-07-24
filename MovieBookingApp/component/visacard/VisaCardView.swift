//
//  VisaCardView.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 12/07/2021.
//

import UIKit

class VisaCardView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    */

    let visalbl : UILabel = {
        let label = UILabel()
        label.text = "Visa"
        label.textColor = .white
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let settingIV : UIImageView = {
        let image = UIImageView(image: UIImage(named: "setting_ic"))
        return image
    }()
    let visaCardNolbl : UILabel = {
        let label = UILabel()
        label.text = "**** **** **** 0976"
        label.textColor = .white
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let expiredlbl : UILabel = {
        let label = UILabel()
        label.text = "Expired"
        label.textColor = .white
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let cardHolederlbl : UILabel = {
        let label = UILabel()
        label.text = "Card Holder"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let cardHolderNamelbl : UILabel = {
        let label = UILabel()
        label.text = "LiLy Jhoson"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let datelbl : UILabel = {
        let label = UILabel()
        label.text = " 09/02"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let mainVStack = UIStackView()
    let nameHStack = UIStackView()
    let titleHStack = UIStackView()
    
    override func draw(_ rect: CGRect) {
       
        setUpMainStackView()
        
    }
    fileprivate func setUpTitleHStackView(){
     
        titleHStack.distribution = .equalSpacing
        titleHStack.alignment = .fill
        titleHStack.spacing = 10
        nameHStack.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        titleHStack.addArrangedSubview(cardHolederlbl)
        titleHStack.addArrangedSubview(expiredlbl)
        
    }
    
    fileprivate func setUpNameHStackView(){
        
        nameHStack.distribution = .equalSpacing
        nameHStack.alignment = .top
        nameHStack.spacing = 10
        nameHStack.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        nameHStack.addArrangedSubview(cardHolderNamelbl)
        nameHStack.addArrangedSubview(datelbl)
        
    }
   
    
    fileprivate func setUpMainStackView(){
        setUpNameHStackView()
        setUpTitleHStackView()
        
        mainVStack.axis = .vertical
        mainVStack.distribution = .fill
        mainVStack.alignment = .fill
        mainVStack.spacing = 24
        mainVStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        mainVStack.isLayoutMarginsRelativeArrangement = true
        mainVStack.backgroundColor = UIColor(named: "color_secondary")
        mainVStack.addArrangedSubview(visalbl)
        mainVStack.addArrangedSubview(visaCardNolbl)
        mainVStack.addArrangedSubview(titleHStack)
        mainVStack.addArrangedSubview(nameHStack)

        addSubview(mainVStack)
        setUpConstraintForStackView()
    }
    fileprivate func setUpConstraintForStackView(){
        mainVStack.translatesAutoresizingMaskIntoConstraints = false
        

        mainVStack.translatesAutoresizingMaskIntoConstraints = false
        mainVStack.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        mainVStack.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        mainVStack.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        mainVStack.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
    }
    
     func setGradientBackground() {
        let colorTop =  UIColor(red: 20, green: 201, blue: 203, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 8, green: 179, blue: 229, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
                
        self.layer.insertSublayer(gradientLayer, at:0)
    }
    

}
