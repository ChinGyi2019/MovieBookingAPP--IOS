//
//  DayViewController+DateExtension.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 20/07/2021.
//

import Foundation


extension DateViewController{
    
    func daysBetweenDates(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)
        return components.day!
    }
    
    func createDatesByInterval(startDate : Date, endDate : Date) -> [Date] {
        
        let dateDiff : Int = daysBetweenDates(startDate: startDate, endDate: endDate)
        var dateArray = [Date]()
       
        for index in 0 ..< dateDiff {
            let modifiedDate = Calendar.current.date(byAdding: .day, value: index, to: Date())!
            dateArray.append(modifiedDate)
        }
        
        return dateArray
        
    }
    
   
}
