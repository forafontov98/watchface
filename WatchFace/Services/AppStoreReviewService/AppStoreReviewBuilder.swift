//
//  AppStoreReviewBuilder.swift
//  WatchFace
//
//  Created by MacBook on 14.01.2021.
//

import Foundation

class AppStoreReviewBuilder {
    
    func buildUrl(appId: String) -> URL? {
        
        guard let url = URL(string : "itms-apps:itunes.apple.com/us/app/apple-store/id\(appId)?mt=8&action=write-review") else {
            return nil
        }
        
        return url
    }
    
}
