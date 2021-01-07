//
//  LeftMenuRouter.swift
//  WatchFace
//
//  Created by MacBook on 09.12.2020.
//

import UIKit

protocol ILeftMenuRouter {
    func cancelBtnPressed()
    
    func presentAboutScreen()
    func presentSubscriptionInfoScreen()
    func presentPrivacyScreen()
    func presentSupportScreen()
}

class LeftMenuRouter: NSObject, ILeftMenuRouter {

    private weak var view: LeftMenuVC?
    
    init(view: LeftMenuVC) {
        self.view = view
    }
    
    func cancelBtnPressed() {
        view?.dismiss(animated: true, completion: nil)
    }
    
    func presentAboutScreen() {
        presentWebView(url: "https://www.watch-faces.org")
    }
    
    func presentSubscriptionInfoScreen() {
        presentWebView(url: "https://www.watch-faces.org/subscription.html")
    }
    
    func presentPrivacyScreen() {
        presentWebView(url: "https://www.watch-faces.org/privacy.html")
    }
    
    func presentSupportScreen() {
        presentWebView(url: "https://www.watch-faces.org/support.html")
    }
    
    private func presentWebView(url: String) {
        let vc = WebViewBuilder().build(url: url)
        view?.present(vc, animated: true, completion: nil)
    }
}
