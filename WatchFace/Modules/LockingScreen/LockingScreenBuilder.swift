//
//  LockingScreenBuilder.swift
//  WatchFace
//
//  Created by MacBook on 11.12.2020.
//

import UIKit

class LockingScreenBuilder: NSObject {

    func build(delegate: LockingScreenPresenterDelegate? = nil) -> UIViewController {
        let vc = LockingScreenVC()
        
        let router = LockingScreenRouter(view: vc)
        let interactor = LockingScreenInteractor()
        let presenter = LockingScreenPresenter(view: vc, router: router, interactor: interactor)
        
        presenter.delegate = delegate
        
        vc.setPresenter(presenter)
        
        return vc
    }
    
}
