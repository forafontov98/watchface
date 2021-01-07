//
//  LeftMenuInteractor.swift
//  WatchFace
//
//  Created by MacBook on 03.01.2021.
//

import UIKit

protocol ILeftMenuInteractor {
    func rateTheApp()
}

class LeftMenuInteractor: NSObject, ILeftMenuInteractor {
    
    func rateTheApp() {
        AppStoreReviewManager().rateApp(appId: "1544672333")
    }

}
