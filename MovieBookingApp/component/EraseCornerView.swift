//
//  EraseCornerView.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 08/06/2021.
//
import UIKit
import Foundation


public class EraseCornerView: UIView {

    private let leftCircle = UIView(frame: .zero)
    private let rightCircle = UIView(frame: .zero)

    public var circleY: CGFloat = 0
    public var circleRadius: CGFloat = 0

    public override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        
        addSubview(leftCircle)
        addSubview(rightCircle)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clipsToBounds = true
        addSubview(leftCircle)
        addSubview(rightCircle)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        leftCircle.backgroundColor = UIColor(named: "color_gray")
        rightCircle.backgroundColor =  UIColor(named: "color_gray")
       // leftCircle.backgroundColor = superview?.backgroundColor
        leftCircle.frame = CGRect(x: -circleRadius, y: circleY,
                                  width: circleRadius * 2 , height: circleRadius * 2)
        leftCircle.layer.masksToBounds = true
        leftCircle.layer.cornerRadius = circleRadius

       // rightCircle.backgroundColor = superview?.backgroundColor
        rightCircle.frame = CGRect(x: bounds.width - circleRadius, y: circleY,
                                   width: circleRadius * 2 , height: circleRadius * 2)
        rightCircle.layer.masksToBounds = true
        rightCircle.layer.cornerRadius = circleRadius
    }
}
