//
//  WelcomeTourPresenter.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

protocol IWelcomeTourPresenter {
    func presentSecondScreen()
    func presentThirdScreen()
    
    func cancelBtnPressed()
    func dismissToRoot()
    func dismiss()
    
    func presentPrivacyScreen()
    func presentTermsScreen()
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
        
        loadProducts()
    }
    
    func presentSecondScreen() {
        router?.presentSecondScreen()
    }
    
    func presentThirdScreen() {
        router?.presentThirdScreen()
    }
    
    func cancelBtnPressed() {
        guard let vc = view else { return }
        
        if let _ = vc.presentingViewController as? SecondScreenVC {
            router?.dismissToRoot()
        } else {
            router?.dismiss()
        }
    }
    
    func dismissToRoot() {
        router?.dismissToRoot()
    }
    
    func dismiss() {
        router?.dismiss()
    }
    
    func presentPrivacyScreen() {
        router?.presentPrivacyScreen()
    }
    
    func presentTermsScreen() {
        router?.presentTermsScreen()
    }
    
    func loadProducts() {
        interactor?.loadProducts()
    }
}
