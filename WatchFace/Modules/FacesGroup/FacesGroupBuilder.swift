//
//  FacesGroupBuilder.swift
//  WatchFace
//
//  Created by MacBook on 09.12.2020.
//

import UIKit

class FacesGroupBuilder: NSObject {

    func build() -> UIViewController {
        let vc = FacesGroupVC()
        
        let router = FacesGroupRouter(view: vc)
        let interactor = FacesGroupInteractor()
        let presenter = FacesGroupPresenter(view: vc, router: router, interactor: interactor)
        
        vc.setPresenter(presenter)
        
        return vc
    }
    
}
