//
//  AppDelegate.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit
import SideMenu
import GoogleMobileAds
import SwiftyStoreKit
import YandexMobileMetrica
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let leftMenuNavigationController = LeftMenuBuilder().build()
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController as? SideMenuNavigationController
        
        if #available(iOS 13, *) {

        } else {
            window = UIWindow()
            
            let vc = StartScreenBuilder().build()
            
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
            
            /*
            let vc = WatchFacesListBuilder().build()
            let nvc = UINavigationController(rootViewController: vc)
            
            window?.rootViewController = nvc
            window?.makeKeyAndVisible()
            */
        }
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        // MARK:- AppMetrika config
        let configuration = YMMYandexMetricaConfiguration.init(apiKey: SDKKeys.appMetrikaApiKey)
        YMMYandexMetrica.activate(with: configuration!)
        
        // MARK:- InAppPurchases config
        
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
                for purchase in purchases {
                    switch purchase.transaction.transactionState {
                    case .purchased, .restored:
                        if purchase.needsFinishTransaction {
                            // Deliver content from server, then:
                            SwiftyStoreKit.finishTransaction(purchase.transaction)
                        }
                        // Unlock content
                    case .failed, .purchasing, .deferred:
                        break // do nothing
                    }
                }
            }
        
        /// Загрузка покупок из ItunesConnect
        SwiftyStoreService.shared.fetchProducts()
        
        /// Проверка текущих подписок пользователя
        SwiftyStoreService.shared.verifyPurchase()
        
        return true
    }
}
