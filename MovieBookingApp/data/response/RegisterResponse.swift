//
//  RegisterResponse.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 17/07/2021.
//

import Foundation
import CoreData


// MARK: - RegisterListResponse
struct RegisterResponse: Codable {
    let code: Int?
    let message: String?
    let data: UserData?
    let token: String?
    
    enum  CodingKeys: String, CodingKey {
        case code, message, data, token
    }
}

// MARK: - UserData
struct UserData: Codable {
    let id: Int?
    let name, email, phone: String?
    let totalExpense: Int?
    let profileImage: String?
    let cards: [Card]?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone
        case totalExpense = "total_expense"
        case profileImage = "profile_image"
        case cards
    }
    
    @discardableResult
    func toProfileEntity(_ context : NSManagedObjectContext) -> ProfileEntity {
        
        let entity = ProfileEntity(context: context)
        
        entity.id = 1
        entity.name = name
        entity.email = email
        entity.phone = phone
        entity.profilePath = profileImage
        cards?.forEach{
            entity.addToCard($0.toCardEntity(context))
        }
        return entity
        
    }
}


// MARK: - Card
struct Card: Codable {
    let id: Int?
    let cardHolder, cardNumber, expirationDate, cardType,cvc: String?

    enum CodingKeys: String, CodingKey {
        case id
        case cardHolder = "card_holder"
        case cardNumber = "card_number"
        case expirationDate = "expiration_date"
        case cardType = "card_type"
        case cvc = "cvc"
    }
    
    func toCardEntity(_ context : NSManagedObjectContext) -> CardEntity {
        let entity = CardEntity(context: context)
        entity.id = Int32(id ?? 0)
        entity.cardHolder = cardHolder
        entity.cardNumber = cardNumber
        entity.expirationDate = expirationDate
        entity.cardType = cardType
        entity.cvc = cvc
        
        return entity
       
    }
}

