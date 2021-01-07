//
//  WelcomeTourInteractor.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

protocol IWelcomeTourInteractor {
    var storeService: ISwiftyStoreService { get }
    
    func loadProducts()
}

class WelcomeTourInteractor: NSObject, IWelcomeTourInteractor {

    let storeService: ISwiftyStoreService = SwiftyStoreService()
    
    override init() {
        super.init()
    }
    
    func loadProducts() {
        storeService.getProducts()
    }
}
