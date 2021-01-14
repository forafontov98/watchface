//
//  Keys.swift
//  WatchFace
//
//  Created by MacBook on 12.01.2021.
//

import Foundation

enum Keys {
    static let WT_was_shown = "WT_was_shown"
    
    static let purchase_state_changed = "purchase_state_changed"
    
    static let not_show_again = "not_show_again"
}

enum EventKeys {
    static let start_ad = "start_ad"
    
    static let finished_ad = "finished_ad"
    
    static let start_trial = "start_trial"
    
    static let purchase = "purchase"
}

enum SDKKeys {
    
    /// ID встроенных покупок
    static let sharedSecretKey = "100a29445ee34f0c9a6ffcd96e8b48e0"
    
    /// API Key AppMetrika
    static let appMetrikaApiKey = "26caac98-8297-41ac-adb0-af85f42b93c5"
    
    /// ID для просмотра рекламы AdMob
    static var adUnitId: String {
        #if DEBUG
        return "ca-app-pub-3940256099942544/1712485313"
        
        #else
        return "ca-app-pub-3879292139547812/5812841522"
        
        #endif
    }
}
