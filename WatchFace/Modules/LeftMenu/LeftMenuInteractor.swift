//
//  LeftMenuInteractor.swift
//  WatchFace
//
//  Created by MacBook on 03.01.2021.
//

import UIKit

protocol ILeftMenuInteractor {
    func rateTheApp()
    func restorePurchases(callback: @escaping RestoreResult)

}

class LeftMenuInteractor: NSObject, ILeftMenuInteractor {
    
    func rateTheApp() {
        AppStoreReviewService().rateApp(appId: "1544672333")
    }

    func restorePurchases(callback: @escaping RestoreResult) {
        SwiftyStoreService.shared.restorePurchases(callback: callback)
    }
}
