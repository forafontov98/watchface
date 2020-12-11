//
//  WelcomeTourPresenter.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

protocol IWelcomeTourPresenter {
    
}

class WelcomeTourPresenter: NSObject, IWelcomeTourPresenter {

    private weak var view: UIViewController?
    private var interactor: IWelcomeTourInteractor?
    private var router: IWelcomeTourRouter?
    
    init(view: UIViewController, interactor: IWelcomeTourInteractor, router: IWelcomeTourRouter) {
        super.init()
        
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}
