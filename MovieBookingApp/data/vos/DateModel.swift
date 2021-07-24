//
//  DateModel.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 20/07/2021.
//

import Foundation

class DateModel{
    
    var date : Date
    var isSelected : Bool = false
    
    init(date : Date, isSelected : Bool) {
        self.date = date
        self.isSelected = isSelected
    }
}
