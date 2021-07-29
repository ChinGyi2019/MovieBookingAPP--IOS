//
//  CinemaDayTimeSlot.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 20/07/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cinemaDayTimeSlotResponse = try? newJSONDecoder().decode(CinemaDayTimeSlotResponse.self, from: jsonData)

import Foundation

// MARK: - CinemaDayTimeSlotResponse
struct CinemaDayTimeSlotResponse: Codable {
    let code: Int?
    let message: String?
    let data: [Cinema]?
    
    enum CodingKeys: String, CodingKey {
        case message, data, code
    }
}

// MARK: - Cinema
class Cinema: Codable {
    var cinemaID: Int?
    var cinema: String?
    var timeslots: [Timeslot]?
    
    init() {
        self.cinemaID = 0
        self.cinema = ""
        self.timeslots = [Timeslot]()
    }
    
    init(cinemaID: Int?, cinema : String?, timeslots : [Timeslot]?) {
        self.cinemaID = cinemaID
        self.cinema = cinema
        self.timeslots = timeslots
    }


    enum CodingKeys: String, CodingKey {
        case cinemaID = "cinema_id"
        case cinema, timeslots
    }
}

// MARK: - Timeslot
class Timeslot: Codable {
    var cinemaDayTimeslotID: Int?
    var startTime: String?
    var isSelected : Bool = false
    init() {
        self.cinemaDayTimeslotID = 0
        self.startTime = ""
        self.isSelected = false
    }
    
    init(cinemaDayTimeslotID: Int?, startTime : String, isSelected : Bool) {
        self.cinemaDayTimeslotID = cinemaDayTimeslotID
        self.startTime = startTime
        self.isSelected = isSelected
    }

    enum CodingKeys: String, CodingKey {
        case cinemaDayTimeslotID = "cinema_day_timeslot_id"
        case startTime = "start_time"
    }
    
 
}



