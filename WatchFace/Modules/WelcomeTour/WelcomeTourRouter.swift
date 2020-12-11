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
}
