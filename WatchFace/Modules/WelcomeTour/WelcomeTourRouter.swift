//
//  WelcomeTourRouter.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

protocol IWelcomeTourRouter {
    func presentSecondScreen()
    func presentThirdScreen()
    
    func dismissToRoot()
    func dismiss()
    
    func presentPrivacyScreen()
    func presentTermsScreen()
}

class WelcomeTourRouter: NSObject, IWelcomeTourRouter {

    private weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }
    
    func presentSecondScreen() {
        let vc = WelcomeTourBuilder().build(screen: .second)
        view?.present(vc, animated: true, completion: nil)
    }
    
    func presentThirdScreen() {
        let vc = WelcomeTourBuilder().build(screen: .third)
        view?.present(vc, animated: true, completion: nil)
    }
    
    func dismissToRoot() {
        view?.hero_unwindToRootViewController()
    }
    
    func dismiss() {
        view?.dismiss(animated: true, completion: nil)
    }
    
    func presentPrivacyScreen() {
        presentWebView(url: "https://www.watch-faces.org/privacy.html")
    }
    
    func presentTermsScreen() {
        presentWebView(url: "https://www.watch-faces.org/terms.html")
    }
    
    private func presentWebView(url: String) {
        let vc = WebViewBuilder().build(url: url)
        view?.present(vc, animated: true, completion: nil)
    }
}
