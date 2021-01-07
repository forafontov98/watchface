//
//  LeftMenuBuilder.swift
//  WatchFace
//
//  Created by MacBook on 09.12.2020.
//

import UIKit

class LeftMenuBuilder: NSObject {

    func build() -> UIViewController {
        let vc = LeftMenuVC()
        let nvc = LeftMenuNVC(rootViewController: vc)
        
        let router = LeftMenuRouter(view: vc)
        let interactor = LeftMenuInteractor()
        let presenter = LeftMenuPresenter(view: vc, router: router, interactor: interactor)
        
        vc.setPresenter(presenter)
        
        return nvc
    }
    
}
