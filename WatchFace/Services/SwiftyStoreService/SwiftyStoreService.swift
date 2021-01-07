//
//  SwiftyStoreService.swift
//  WatchFace
//
//  Created by MacBook on 07.01.2021.
//

import UIKit
import SwiftyStoreKit

protocol ISwiftyStoreService {
    func getProducts()
}

class SwiftyStoreService: NSObject, ISwiftyStoreService {

    let identifiers: Set<String> = [
        "month.trial.subscription",
        "week.trial.subscription",
        "month.subscription.wf",
        "week.subscription.wf"
    ]
    
    func getProducts() {
        SwiftyStoreKit.retrieveProductsInfo(identifiers) { result in
            
            if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
            }
            
            else {
                print("Error: \(result.error)")
            }
            
            for product in result.retrievedProducts {
                
                let priceString = product.localizedPrice!
                print("Product: \(product.localizedDescription), price: \(priceString)")
            }
            
        }
    }
    
}
