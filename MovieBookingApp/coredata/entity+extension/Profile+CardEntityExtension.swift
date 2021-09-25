//
//  Profile+CardEntityExtension.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 12/08/2021.
//

import Foundation


extension ProfileEntity{
    
    static func toUserData(_ entity : ProfileEntity) -> UserData{
        return UserData(id: Int(entity.id),
                        name:entity.name,
                        email:entity.email,
                        phone:entity.phone,
                        totalExpense:Int(entity.totalExpense),
                        profileImage:entity.profilePath,
                        cards:getCardArray(entity.card))
        
    }
    
    static func getCardArray(_ set : NSSet?) -> [Card]{
        
        if let itemSets = set as? Set<CardEntity>{
            return itemSets.map{
                CardEntity.toCard($0)
            }
        }else{
            return [Card]()
        }
    }
}

extension CardEntity{
    static func toCard(_ entity : CardEntity) -> Card{
        
        return Card(id: Int(entity.id),
                    cardHolder: entity.cardHolder,
                    cardNumber: entity.cardNumber,
                    expirationDate: entity.expirationDate,
                    cardType: entity.cardType,
                    cvc: entity.cvc)
        
    }
}
