//
//  ViewExtensions.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 04/06/2021.
//

import Foundation
import UIKit



//ViewContorller

extension UIViewController{
    static var identifier :String{
        String(describing: self)
    }
}
//BorderColor
extension UIView{
    func addBorderLine(radius : Int,width : Int, color: CGColor)  {
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.borderWidth = CGFloat(width)
        self.layer.borderColor = color
    }
}

//UICollectionView' Extensions
extension UICollectionViewCell{
    static var identifier : String{
        String(describing : self)
    }
}
extension UICollectionView{
    
    func registerForCell(identifier : String ){
        register(UINib(nibName: identifier, bundle: nil),forCellWithReuseIdentifier: identifier)
        
    }
    
    func dequeueCell<T:UICollectionViewCell>(identifier: String, indexPath : IndexPath)->T{
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)as? T else{
            return UICollectionViewCell() as! T
            
        }
        return cell
    }
    
    
    
}

extension UIView{
    
    //DashView
    func addDashedBorder() {
            //Create a CAShapeLayer
            let shapeLayer = CAShapeLayer()
            shapeLayer.strokeColor = UIColor.gray.cgColor
            shapeLayer.lineWidth = 1
            // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [5,5]

            let path = CGMutablePath()
            path.addLines(between: [CGPoint(x: 0, y: 0),
                                    CGPoint(x: self.frame.width, y: 0)])
            shapeLayer.path = path
            layer.addSublayer(shapeLayer)
        }
}
//MARK:- Show Toast
extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
}
    
    func showAlert(title : String, message : String){
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

//MARK:- UITextField
extension UITextField {
    func setBottomBorderOnlyWith(color: CGColor) {
        self.borderStyle = .none
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func isError(baseColor: CGColor, numberOfShakes shakes: Float, revert: Bool) {
            let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
            animation.fromValue = baseColor
            animation.toValue = UIColor.red.cgColor
            animation.duration = 0.4
            if revert { animation.autoreverses = true } else { animation.autoreverses = false }
            self.layer.add(animation, forKey: "")

            let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
            shake.duration = 0.07
            shake.repeatCount = shakes
            if revert { shake.autoreverses = true  } else { shake.autoreverses = false }
            shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
            shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
            self.layer.add(shake, forKey: "position")
        }
}
