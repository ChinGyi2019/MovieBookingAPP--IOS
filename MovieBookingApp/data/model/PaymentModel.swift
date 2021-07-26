//
//  PaymentModel.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 23/07/2021.
//

import Foundation

protocol PaymentModel {
    
    func fetchSnackList(completion: @escaping (NetworkResult<SnackListResponse>) -> Void)
    
    func fetchPaymentMethods(completion: @escaping (NetworkResult<PaymentMethodListResponse>) -> Void)
    
    func getProfile(completion: @escaping (NetworkResult<ProfileResponse>) -> Void)
    func addNewCard(card: Card, completion: @escaping (NetworkResult<AddNewCardResponse>) -> Void)
    
    func checkOut(checkOut: CheckOutModel, completion: @escaping (NetworkResult<CheckOutResponse>) -> Void)
    

}

class PaymentModelImpl: BaseModel, PaymentModel {
    
    static var shared = PaymentModelImpl()
    
    override init() {}
    
    func fetchSnackList(completion: @escaping (NetworkResult<SnackListResponse>) -> Void) {
        networkingAgent.fetchSnackList(completion: completion)
    }
    
    
    func fetchPaymentMethods(completion: @escaping (NetworkResult<PaymentMethodListResponse>) -> Void) {
        networkingAgent.fetchPaymentMethods(completion: completion)
    }
    
    func getProfile(completion: @escaping (NetworkResult<ProfileResponse>) -> Void) {
        networkingAgent.getProfile(completion: completion)
    }
    
    func addNewCard(card: Card, completion: @escaping (NetworkResult<AddNewCardResponse>) -> Void) {
        networkingAgent.addNewCard(card: card, completion: completion)
    }
    
    func checkOut(checkOut: CheckOutModel, completion: @escaping (NetworkResult<CheckOutResponse>) -> Void) {
        networkingAgent.checkOut(checkOut: checkOut, completion: completion)
    }
    
    
    
}
