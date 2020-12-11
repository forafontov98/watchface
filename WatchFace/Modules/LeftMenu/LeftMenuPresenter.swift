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
    
    init(view: LeftMenuVC, router: ILeftMenuRouter) {
        self.view = view
        self.router = router
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
