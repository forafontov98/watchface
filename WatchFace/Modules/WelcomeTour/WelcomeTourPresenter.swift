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
    
    func presentPrivacyScreen()
    func presentTermsScreen()
        
    func getProducts(callback: @escaping(
                        _ weekPrice: String?,
                        _ montnPrice: String?)->Void)
    
    var sourceScreen: SourceScreen? { get set }
    
    func weekBtnPressed()
    func monthBtnPressed()
    
    func purchase()
    func restore()
}

class WelcomeTourPresenter: NSObject, IWelcomeTourPresenter {

    private weak var view: UIViewController?
    private var interactor: IWelcomeTourInteractor?
    private var router: IWelcomeTourRouter?
    
    private var weekIA = IAProduct.weekTrial
    private var monthIA = IAProduct.monthTrial
    
    private var selectedIA = IAProduct.weekTrial
            
    var sourceScreen: SourceScreen? {
        didSet {
            guard let sourceScreen = sourceScreen else { return }
            if let view = view as? ThirdScreenVC {
                view.sourceScreen = sourceScreen
            }
            
            weekIA = sourceScreen == .app ? IAProduct.week : IAProduct.weekTrial
            monthIA = sourceScreen == .app ? IAProduct.month : IAProduct.monthTrial
            selectedIA = weekIA
        }
    }

    init(view: UIViewController, interactor: IWelcomeTourInteractor, router: IWelcomeTourRouter) {
        super.init()
        
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func presentSecondScreen() {
        router?.presentSecondScreen()
    }
    
    func presentThirdScreen() {
        router?.presentThirdScreen()
    }
    
    func cancelBtnPressed() {
        setWelcomeTourWasShown()
        router?.dismiss()
    }
    
    func presentPrivacyScreen() {
        router?.presentPrivacyScreen()
    }
    
    func presentTermsScreen() {
        router?.presentTermsScreen()
    }
    
    func weekBtnPressed() {
        selectedIA = weekIA
    }
    
    func monthBtnPressed() {
        selectedIA = monthIA
    }
    
    private func setWelcomeTourWasShown() {
        UserDefaults.standard.setValue(true, forKey: Keys.WT_was_shown)
    }
    
    func purchase() {
        guard let view = view as? ThirdScreenVC else { return }
            
        view.mainView?.nextBtn.load(true)

        interactor?.purchase(selectedIA) { (result) in
            view.mainView?.nextBtn.load(false)
                        
            switch result {
            case .purchased(expiryDate: _, items: _):

                self.setWelcomeTourWasShown()

                if let sourceScreen = self.sourceScreen, sourceScreen == .app {
                    self.interactor?.sendPurchaseEvent()
                    self.router?.dismissToClass(WatchPreviewVC.self)
                } else {
                    self.interactor?.sendTrialStartEvent()
                    self.router?.dismiss()
                }
                
            case .expired(expiryDate: let expiryDate, items: _):
                
                let df = DateFormatter()
                df.dateFormat = "dd.MM.YYYY HH:mm"
                let expStr = df.string(from: expiryDate)
                
                self.router?.presentAlert(
                    title: "Expired".localized,
                    message: "Your subscription has expired".localized + " \(expStr)",
                    completion: nil)
                
            default:
                self.router?.presentAlert(
                    title: "Mistake".localized,
                    message: "The subscription was not paid for".localized,
                    completion: nil)
            }
        }
    }

    func restore() {
        interactor?.restorePurchases { (response) in
            switch response {
            
            case .restoreSuccess:
                self.setWelcomeTourWasShown()

                self.router?.presentAlert(
                    title: "Success".localized,
                    message: nil,
                    completion: {
                        if let sourceScreen = self.sourceScreen, sourceScreen == .app {
                            self.router?.dismissToClass(WatchPreviewVC.self)
                        } else {
                            self.router?.dismiss()
                        }
                    })
                
            default:
                self.router?.presentAlert(
                    title: "Mistake".localized,
                    message: nil,
                    completion: nil)
            }
        }
    }

    
    func getProducts(callback: @escaping(_ weekPrice: String?, _ montnPrice: String?)->Void) {
        
        guard let products = interactor?.getProducts() else {
            
            interactor?.loadProducts(callback: { (productsInfo) in
                let weekTrial = productsInfo.first(where: { $0.id == self.weekIA})
                let monthTrial = productsInfo.first(where: { $0.id == self.monthIA})
                
                callback(weekTrial?.value.localizedPrice, monthTrial?.value.localizedPrice)
            })
            
            return
        }
        
        let weekTrial = products.first(where: { $0.id == weekIA})
        let monthTrial = products.first(where: { $0.id == monthIA})
        
        callback(weekTrial?.value.localizedPrice, monthTrial?.value.localizedPrice)
    }
}
