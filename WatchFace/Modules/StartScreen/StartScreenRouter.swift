//
//  StartScreenRouter.swift
//  WatchFace
//
//  Created by MacBook on 14.01.2021.
//

import UIKit

protocol IStartScreenRouter {
    func presentWelcomeTour()
    func presentFaceList()
}

class StartScreenRouter: NSObject, IStartScreenRouter {

    private weak var view: StartScreenVC?
    
    init(view: StartScreenVC) {
        self.view = view
    }
    
    func presentWelcomeTour() {
        let vc = WelcomeTourBuilder().build(screen: .first)
        view?.present(vc, animated: true, completion: nil)
    }
    
    func presentFaceList() {
        let vc = WatchFacesListBuilder().build()
        let nvc = UINavigationController(rootViewController: vc)
        nvc.modalPresentationStyle = .fullScreen
        view?.present(nvc, animated: false, completion: nil)
    }
}
