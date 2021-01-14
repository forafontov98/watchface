//
//  SwiftyStoreService.swift
//  WatchFace
//
//  Created by MacBook on 07.01.2021.
//

import UIKit
import SwiftyStoreKit
import StoreKit

typealias ProductsResult = ([IAProductInfo]) -> Void
typealias PurchaseResult = (VerifySubscriptionResult?) -> Void
typealias RestoreResult = (RestoreResponse) -> Void

protocol ISwiftyStoreService {
    func fetchProducts()
    func fetchProducts(callback: @escaping ProductsResult)

    var inAppProducts: [IAProductInfo] { get }
    
    func purchase(_ inAppProduct: IAProduct, callback: @escaping PurchaseResult)
    func restorePurchases(callback: @escaping RestoreResult)
    
    func verifyPurchase()
    
    var isPro: Bool { get }
}

class SwiftyStoreService: ISwiftyStoreService {

    
    //MARK:- Singleton variables
    static var shared: ISwiftyStoreService = SwiftyStoreService()

    private init() { }

    
    //MARK:- Private variables
  
    private let inapp_expired_key = "inapp_expired"

    /// Private products to purchases with id: IAProduct and value: SKProduct
    private var products: [IAProductInfo] = []
        
    /// URL to verify purchase
    private var receiptURLType: AppleReceiptValidator.VerifyReceiptURLType {
        #if DEBUG
        return AppleReceiptValidator.VerifyReceiptURLType.sandbox
        
        #else
        return AppleReceiptValidator.VerifyReceiptURLType.production
        
        #endif
    }
    
    
    //MARK:- Public variables

    /// Public products to purchases with id: IAProduct and value: SKProduct
    var inAppProducts: [IAProductInfo] {
        return products
    }

    
    /// Public value indicating purchased subscription
    var isPro: Bool {
        get {
            guard let expiryString = UserDefaults.standard.string(forKey: inapp_expired_key) else {
                return false
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-mm-dd HH:mm:ss Z"
            
            guard let expiryDate = dateFormatter.date(from: expiryString) else {
                return false
            }
            
            let nowDate = Date()
            
            return nowDate < expiryDate
        }
    }
    
    //MARK:- Public methods

    
    /**
     Public method to fetch all products and save it locally to "products"
     */
    func fetchProducts() {
        fetchProducts { (products) in
            self.products = products
        }
    }
    
    
    /**
     Public method to fetch all products
     */
    func fetchProducts(callback: @escaping ProductsResult) {

        let identifiers = IAProduct.allCases.map({$0.rawValue})
        
        SwiftyStoreKit.retrieveProductsInfo(Set(identifiers)) { result in
            
            if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
            } else if let error = result.error {
                print("Error: \(error)")
            }
            
            var productsInfo: [IAProductInfo] = []
            
            for value in result.retrievedProducts {
                if let product = IAProduct(rawValue: value.productIdentifier) {
                    productsInfo.append(IAProductInfo(id: product, value: value))
                }
            }
            
            callback(productsInfo)
        }
    }
    
    
    /**
     Public method to verify purchases and update expiryDate in UserDefaults
     */
    func verifyPurchase() {
        
        let appleValidator = AppleReceiptValidator(service: receiptURLType, sharedSecret: SDKKeys.sharedSecretKey)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let productIds = Set(IAProduct.allCases.map({$0.rawValue}))

                let purchaseResult = SwiftyStoreKit.verifySubscriptions(
                    productIds: productIds,
                    inReceipt: receipt)
                    
                switch purchaseResult {
                case .purchased(let expiryDate, let items):
                    print("\(productIds) is valid until \(expiryDate)\n\(items)\n")
                    
                    self.updateExpiryDate(expiryDate)
                    
                case .expired(let expiryDate, _):
                    self.updateExpiryDate(expiryDate)

                case .notPurchased:
                    print("The user has never purchased \(productIds)")
        
                }

            case .error(let error):
                print("Receipt verification failed: \(error)")

            }
        }
    }
    
    
    /**
     Public method to purchase product
     - parameter inAppProduct:  Product that user want to purchase
     - parameter callback:      A block which will be called when product has purchased/not purchased
     */
    func purchase(_ inAppProduct: IAProduct, callback: @escaping PurchaseResult) {
        
        SwiftyStoreKit.purchaseProduct(inAppProduct.rawValue, atomically: true) { result in
            
            switch result {
            case .success(let purchase):

                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
                
                let appleValidator = AppleReceiptValidator(service: self.receiptURLType, sharedSecret: SDKKeys.sharedSecretKey)
                SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
                    
                    if case .success(let receipt) = result {
                        let purchaseResult = SwiftyStoreKit.verifySubscription(
                            ofType: .autoRenewable,
                            productId: inAppProduct.rawValue,
                            inReceipt: receipt)
                        
                        switch purchaseResult {
                        case .purchased(let expiryDate, _):
                            self.updateExpiryDate(expiryDate)

                            print("Product is valid until \(expiryDate)")
                            
                        case .expired(let expiryDate, _):
                            self.updateExpiryDate(expiryDate)

                            print("Product is expired since \(expiryDate)")

                        case .notPurchased:
                            print("This product has never been purchased")

                        }

                        callback(purchaseResult)

                    } else {
                        callback(nil)

                    }
                }
            case .error(error: _):
                callback(nil)
                
            }
        }
    }
    
    
    /**
     Public method to restore product
     - parameter callback:      A block which will be called when product has restored/not restored
     */
    func restorePurchases(callback: @escaping RestoreResult) {
        
        let appleValidator = AppleReceiptValidator(service: receiptURLType, sharedSecret: SDKKeys.sharedSecretKey)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let productIds = Set(IAProduct.allCases.map({$0.rawValue}))

                let purchaseResult = SwiftyStoreKit.verifySubscriptions(
                    productIds: productIds,
                    inReceipt: receipt)
                    
                switch purchaseResult {
                case .purchased(let expiryDate, let items):
                    print("\(productIds) is valid until \(expiryDate)\n\(items)\n")
                    
                    self.updateExpiryDate(expiryDate)
                    callback(.restoreSuccess)
                    
                case .expired(let expiryDate, _):
                    self.updateExpiryDate(expiryDate)
                    callback(.restoreFailed)

                case .notPurchased:
                    print("The user has never purchased \(productIds)")
                    callback(.restoreFailed)

                }

            case .error(let error):
                print("Receipt verification failed: \(error)")
                callback(.restoreFailed)

            }
        }
        
    }
    
    /**
     Private method to update expiration date of subscription in UserDefaults
     - parameter date:      expiration date
     */
    private func updateExpiryDate(_ date: Date) {
        UserDefaults.standard.setValue("\(date)", forKey: inapp_expired_key)
        Notify.post(name: Keys.purchase_state_changed)
    }
}
