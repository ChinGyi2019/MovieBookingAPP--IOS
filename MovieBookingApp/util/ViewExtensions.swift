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
