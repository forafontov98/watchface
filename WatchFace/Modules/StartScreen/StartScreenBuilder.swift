//
//  StartScreenBuilder.swift
//  WatchFace
//
//  Created by MacBook on 14.01.2021.
//

import UIKit

class StartScreenBuilder: NSObject {

    func build() -> UIViewController {
        let vc = StartScreenVC()
        
        let router = StartScreenRouter(view: vc)
        let presenter = StartScreenPresenter(view: vc, router: router)
        
        vc.presenter = presenter
        
        return vc
    }
    
}
