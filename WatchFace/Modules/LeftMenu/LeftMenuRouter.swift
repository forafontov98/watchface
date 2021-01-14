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
    
    func presentAlert(title: String?, message: String?, completion: (()->Void)?)
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
    
    func presentAlert(title: String?, message: String?, completion: (()->Void)? = nil) {
        let alertVC = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: "Ok".localized, style: .cancel, handler: { (_) in
            if let completion = completion {
                completion()
            }
        }))
        
        view?.present(alertVC, animated: true)
    }
}
