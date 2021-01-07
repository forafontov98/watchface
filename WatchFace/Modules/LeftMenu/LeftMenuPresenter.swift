//
//  LeftMenuPresenter.swift
//  WatchFace
//
//  Created by MacBook on 09.12.2020.
//

import UIKit

protocol ILeftMenuPresenter: UITableViewDataSource, UITableViewDelegate {
    func cancelBtnPressed()
}

class LeftMenuPresenter: NSObject, ILeftMenuPresenter {

    private weak var view: LeftMenuVC?
    private var router: ILeftMenuRouter?
    private var interactor: ILeftMenuInteractor?
    
    init(view: LeftMenuVC, router: ILeftMenuRouter, interactor: ILeftMenuInteractor) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func cancelBtnPressed() {
        router?.cancelBtnPressed()
    }
}

extension LeftMenuPresenter {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeftMenuTVC.className, for: indexPath) as! LeftMenuTVC
        cell.config(MenuItem.allCases[indexPath.row].rawValue)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch MenuItem.allCases[indexPath.row] {
        case .about:
            router?.presentAboutScreen()
            
        case .subscriptionInfo:
            router?.presentSubscriptionInfoScreen()
            
        case .privacyPolicy:
            router?.presentPrivacyScreen()
            
        case .rateTheApp:
            interactor?.rateTheApp()
            
        case .support:
            router?.presentSupportScreen()
            
        case .restorePurchases:
            print("Restore purchases!")
        }
    }
}

enum MenuItem: String, CaseIterable {
    case about = "About"
    case subscriptionInfo = "Subscription info"
    case privacyPolicy = "Privacy policy"
    case rateTheApp = "Rate the app"
    case support = "Support"
    case restorePurchases = "Restore purchases"
}
