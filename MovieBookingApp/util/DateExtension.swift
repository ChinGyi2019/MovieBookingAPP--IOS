//
//  DateExtension.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 20/07/2021.
//

import Foundation

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
    
  

    var onlyDay : String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }
    
    var formattedDate : String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    var formattedMonthDate : String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE-MM-MMM"
        return formatter.string(from: self)
    }
    
    func toDateModel() -> DateModel {
        return DateModel(date: self,isSelected: false)
    }
}

extension String{
    
    var toDate : Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self) ?? Date()
    }
  
}
