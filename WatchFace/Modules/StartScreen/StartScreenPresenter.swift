//
//  StartScreenPresenter.swift
//  WatchFace
//
//  Created by MacBook on 14.01.2021.
//

import UIKit

protocol IStartScreenPresenter {
    func presentMainScreen()
}

class StartScreenPresenter: NSObject, IStartScreenPresenter {

    private weak var view: StartScreenVC?
    private var router: IStartScreenRouter?
    
    init(view: StartScreenVC, router: IStartScreenRouter) {
        self.view = view
        self.router = router
    }
    
    func presentMainScreen() {
        if !UserDefaults.standard.bool(forKey: Keys.WT_was_shown) {
            router?.presentWelcomeTour()
        } else {
            router?.presentFaceList()
        }
    }
}

