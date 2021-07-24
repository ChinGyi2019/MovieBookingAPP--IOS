//
//  TimeSlotDelegate.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 20/07/2021.
//

import Foundation


protocol TimeSlotDelegate {
    func  onTapTimeSlot(indexPath: IndexPath,cinema : Cinema, timeSlot: Timeslot)
}
