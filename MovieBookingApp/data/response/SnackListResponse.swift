//
//  SnackListResponse.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 23/07/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let snackListResponse = try? newJSONDecoder().decode(SnackListResponse.self, from: jsonData)

import Foundation

// MARK: - SnackListResponse
struct SnackListResponse: Codable {
    let code: Int?
    let message: String?
    let data: [Snack]?
}

// MARK: - Datum
class Snack: Codable {
    
    var id: Int?
    var name, datumDescription: String?
    var price: Int?
    var amount : Int = 0
    var image: String?
    
    init() {
        self.id = -1
        self.name = ""
        self.datumDescription = ""
        self.price = -1
        self.amount = 0
        self.image = ""
    }
    
    init(id : Int?, name : String?,
         datumDescription : String?,
         price : Int?,
         amount : Int,
         image: String?) {
        
        self.id = id
        self.name = name
        self.datumDescription = datumDescription
        self.price = price
        self.amount = amount
        self.image = image
    }

    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
        case price, image
    }
    
    func  toCheckOutSnack() -> CheckOutSnack {
        return CheckOutSnack(id: self.id, quantity: amount)
    }
}

struct CheckOutSnack : Codable{
    var id: Int?
    var quantity : Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case quantity = "quantity"
    }
}
