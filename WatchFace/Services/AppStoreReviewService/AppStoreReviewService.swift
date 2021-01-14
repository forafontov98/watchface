//
//  AppStoreReviewManager.swift
//  WatchFace
//
//  Created by MacBook on 03.01.2021.
//

import UIKit
import StoreKit

class AppStoreReviewService {
    
    private var builder = AppStoreReviewBuilder()
    
    func requestReviewIfAppropriate() {
        SKStoreReviewController.requestReview()
    }
    
    func rateApp(appId: String) {
        guard let url = builder.buildUrl(appId: appId) else {
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
