//
//  WelcomeTourBuilder.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

class WelcomeTourBuilder: NSObject {

    func build(screen: WelcomeTourScreen) -> UIViewController {
        
        var vc: UIViewController!
        switch screen {
        case .first: vc = FirstScreenVC()
        case .second: vc = SecondScreenVC()
        case .third: vc = ThirdScreenVC()
        }
        
        let router = WelcomeTourRouter(view: vc)
        let interactor = WelcomeTourInteractor()
        let presenter = WelcomeTourPresenter(view: vc, interactor: interactor, router: router)
        
        if let vc = vc as? WelcomeTourController {
            vc.setPresenter(presenter)
        }
        
        return vc
        
    }
    
}

enum WelcomeTourScreen {
    case first
    case second
    case third
}
