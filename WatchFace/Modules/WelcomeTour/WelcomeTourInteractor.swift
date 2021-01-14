//
//  WelcomeTourInteractor.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit
import StoreKit

protocol IWelcomeTourInteractor {
    func getProducts() -> [IAProductInfo]
    func loadProducts(callback: @escaping ProductsResult)
    
    func purchase(_ inAppProduct: IAProduct, callback: @escaping PurchaseResult)
    func restorePurchases(callback: @escaping RestoreResult)
    
    func sendTrialStartEvent()
    func sendPurchaseEvent()
}

class WelcomeTourInteractor: NSObject, IWelcomeTourInteractor {
    
    override init() {
        super.init()
    }
    
    func getProducts() -> [IAProductInfo] {
        return SwiftyStoreService.shared.inAppProducts
    }
    
    func loadProducts(callback: @escaping ProductsResult) {
        SwiftyStoreService.shared.fetchProducts(callback: callback)
    }

    func purchase(_ inAppProduct: IAProduct, callback: @escaping PurchaseResult) {
        SwiftyStoreService.shared.purchase(inAppProduct, callback: callback)
    }

    func restorePurchases(callback: @escaping RestoreResult) {
        SwiftyStoreService.shared.restorePurchases(callback: callback)
    }

    func sendTrialStartEvent() {
        AppEventsService().sendTrialStartEvent()
    }
    
    func sendPurchaseEvent() {
        AppEventsService().sendPurchaseEvent()
    }
}
