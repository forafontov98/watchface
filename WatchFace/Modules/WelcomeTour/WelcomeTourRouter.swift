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
    
    func dismiss()
    
    func presentPrivacyScreen()
    func presentTermsScreen()
    
    func presentAlert(title: String?, message: String?, completion: (()->Void)?)
    func dismissToClass(_ name: AnyClass)

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
    
    func dismiss() {
        if let _ = view?.presentingViewController as? SecondScreenVC {
            view?.hero_unwindToRootViewController()
        } else {
            view?.dismiss(animated: true)
        }
    }
    
    func dismissToClass(_ name: AnyClass) {
        view?.hero_unwindToViewController(withClass: name)
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
