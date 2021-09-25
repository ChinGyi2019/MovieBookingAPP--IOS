//
//  BaseModel.swift
//  MovieBookingApp
//
//  Created by Van Za Lyan Htan on 23/07/2021.
//

import Foundation
import RxSwift

class BaseModel: NSObject {
    
     let networkingAgent = AFNetworkingAgent.shared
    
    let dispseBag = DisposeBag()
}
