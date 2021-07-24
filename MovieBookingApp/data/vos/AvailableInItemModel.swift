//
//  AvailableInItemModel.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 24/07/2021.
//

import Foundation

class AvailableItemModel{
    
    var id: Int?
    var name: String?
    var isSelected : Bool = false
    init() {
        self.id = 0
        self.name = ""
        self.isSelected = false
    }
    
    init(id: Int?, name : String, isSelected: Bool) {
        self.id = id
        self.name = name
        self.isSelected = isSelected
    }

    
}
