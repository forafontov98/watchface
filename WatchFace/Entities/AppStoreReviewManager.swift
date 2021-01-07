//
//  AppStoreReviewManager.swift
//  WatchFace
//
//  Created by MacBook on 03.01.2021.
//

import UIKit
import StoreKit

class AppStoreReviewManager {
    func requestReviewIfAppropriate() {
        SKStoreReviewController.requestReview()
    }
    
    func rateApp(appId: String) {
        guard let url = URL(string : "itms-apps:itunes.apple.com/us/app/apple-store/id\(appId)?mt=8&action=write-review") else {
            requestReviewIfAppropriate()
            return
        }
        
        guard #available(iOS 10, *) else {
            requestReviewIfAppropriate()
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
