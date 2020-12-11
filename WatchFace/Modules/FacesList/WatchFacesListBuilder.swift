//
//  WatchFacesListBuilder.swift
//  WatchFace
//
//  Created by MacBook on 08.12.2020.
//

import UIKit

class WatchFacesListBuilder: NSObject {

    func build() -> UIViewController {
        let vc = WatchFacesListVC()
        
        let router = WatchFacesListRouter(view: vc)
        let interactor = WatchFacesListInteractor()
        let presenter = WatchFacesListPresenter(view: vc, interactor: interactor, router: router)
        
        vc.setPresenter(presenter)
        
        return vc
    }
    
}
